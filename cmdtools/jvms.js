const java_dir = "C:\\Program Files\\Java";
const fs = require("fs");
const { exec } = require("child_process");
const List = require("prompt-list");
var dirs = fs.readdirSync(java_dir);
const isAdmin = require("is-admin");

var list = new List({
  name: "order",
  message:
    "please delete `C:\\Program Files (x86)\\Common Files\\Oracle\\Java\\javapath` from SYSTEM ENVIRONTMENT PATH\n\
  Select java version to be activated?",
  // choices may be defined as an array or a function that returns an array
  choices: dirs,
});

// async
list.ask(function (answer) {
  //console.log(answer);
  //setx JDK_HOME "C:\Program Files\Java\%JAVA_VERSION%" /m
  //setx JAVA_HOME "C:\Program Files\Java\%JAVA_VERSION%" /m
  const java_path = "C:\\Program Files\\Java\\" + answer;

  isAdmin().then((elevated) => {
    if (elevated) {
      //console.log("Elevated");
      exec(
        `setx JAVA_HOME "${java_path}" /m && setx JAVA_HOME "${java_path} && setx JDK_HOME "${java_path}" /m && setx JDK_HOME "${java_path}"`,
        function (err, stdout, stderr) {
          if (err) {
            console.error(`java ${answer} activate failed`);
            console.log(err);
          } else {
            console.log(`java ${answer} activated`);
          }
        }
      );
    } else {
      //console.log("Not elevated");
      console.error("Administrator access required");
    }
  });
});
