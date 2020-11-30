const mysql=require('mysql');
const express=require('express');
const bodyParser=require('body-parser');


var db = mysql.createConnection({
  host:'localhost',
  user:'root',
  password:'password',
  database:'poapper_backend'
});

const app=express();
app.use(express.json());
app.use(express.static(__dirname+'/public'));

app.set('view engine','ejs');
app.set('views','./public');


app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

function calcReaminedTime(now,start_time){
  if(!start_time){
    return "Empty";
  }
  var diff=now-start_time;
  if(diff>2700000){
    return "Time Out";
  }else{ //time remaining
    return (2700000-diff);
  }
}

app.get("/",(req,res)=>{
  db.query(`SELECT * FROM washer`,(err,data)=>{
    if(err) throw err;
    var now=Date.now();
    var remain={};
    for(var i=0;i<16;i++){
      remain[i]=calcReaminedTime(now,data[i].start_time);
      if(remain[i]=='Time Out'){
        db.query(`UPDATE washer SET name=NULL, isEmpty=1, start_time=NULL WHERE id=${i+1}`);
        remain[i]='Empty';
      }
    }
    res.render('home',{'remain':remain});
  });
})

app.post("/update/:id", (req, res) => {
  const body = req.body;
  const query_id = req.params.id;
  db.query(`SELECT isEmpty FROM washer WHERE id=${query_id}`,(err,data)=>{
    console.log(JSON.stringify(data));
    if(!data[0].isEmpty){
      console.log("Already Occupied");
    }
    else{
      db.query(`UPDATE washer SET name='${body.name}',isEmpty=0, start_time=NOW() WHERE id=${query_id}`, (err, data) => {
        if(err) throw err;
      });
    }
    res.render('update',{data:{isEmpty:data[0].isEmpty,case: 'update'}});
  })
})
/*
app.post("/pickedUp/:id", (req, res) => {
  const body = req.body;
  const query_id = req.params.id;
  db.query(`SELECT isEmpty FROM washer WHERE id=${query_id}`,(err,data)=>{
    if(data[0].isEmpty){
      console.log("Already Emptied");
    }
    else{
      db.query(`UPDATE washer SET name=NULL,isEmpty=TRUE,start_time=NULL WHERE id=${query_id}`, (err, data) => {
        if(err) throw err;
      });
    }
    res.render('update',{data:{isEmpty:data[0].isEmpty,case: 'pickedUp'}});
  })
})
*/
app.listen(8080, () => console.log("Server is listening on 8080 port..."));