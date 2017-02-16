//
// Copyright 2012 Square Inc.
// Portions Copyright (c) 2016-present, Facebook, Inc.
// All rights reserved.
// 
// This source code is licensed under the license found in the
// LICENSE-examples file in the root directory of this source tree.
// 

function SocketClient () {
  this.list_elem = document.getElementById('client_list');
  this.info_div = document.getElementById('info_div');
  var self = this;
}

SocketClient.prototype.connect = function () {
  var self = this;

  this.list_elem.innerHTML = '';
  this.info_div.innerHTML = 'status: connecting...'; 
  this.socket = new WebSocket("ws://" + document.location.host + "/chat");  
  
  this.socket.onopen = function () {self.onopen.apply(self, arguments);};
  this.socket.onmessage = function () {self.onmessage.apply(self, arguments);};
  this.socket.onclose = function () {self.onclose.apply(self, arguments);};
};

SocketClient.prototype.deviceAdded = function (params) {
  var el = document.createElement('li');
  el.innerHTML = '<a href="devtools/devtools.html?host=' + document.location.host + '&page=' + params.page + '">' + params.device_name + '</a>' + ' <span class="device_details">(' + params.app_id + ', ' + params.device_model + ', ' + params.device_id + ')</span>';
  this.list_elem.appendChild(el);
  this.visibleElems[params.connection_id] = el;
};

SocketClient.prototype.deviceRemoved = function (params) {
  var li = this.visibleElems[params.connection_id];
  li.parentNode.removeChild(li);
};

SocketClient.prototype.onopen = function () {
  this.info_div.innerHTML = 'status: connected to gateway';
  this.list_elem.innerHTML = '';
  this.visibleElems = {};
  console.log('connection to gateway opened');
};

SocketClient.prototype.onmessage = function (message) {
  var el = document.createElement('li');
  el.innerHTML = message.data;
  window.document.getElementById('history').appendChild(el);
};

SocketClient.prototype.onclose = function () {
  var retryInterval = 1000.0;
  console.log('connection closed, retrying in ' + (retryInterval/1000.0) + ' seconds');
  var self = this;
  window.setTimeout(function () {self.connect();}, retryInterval);
};

function readTextFile(file, callback) {
    var rawFile = new XMLHttpRequest();
    rawFile.overrideMimeType("application/json");
    rawFile.open("GET", file, true);
    rawFile.onreadystatechange = function() {
        if (rawFile.readyState === 4 && rawFile.status == "200") {
            callback(rawFile.responseText);
        }
    }
    rawFile.send(null);
}

window.addEventListener('load', function () {
    var form = window.document.getElementById('msg_form');
    var msg_field = window.document.getElementById('msg_field');
    var btn = window.document.getElementById('push_btn');
    var iBtn = window.document.getElementById('invalid_btn');

    var socketClient = new SocketClient();
    socketClient.connect()

    form.onsubmit = function () {
      msg = msg_field.value;
      msg_field.value = '';

      socketClient.socket.send(msg);

      var el = document.createElement('li');
      el.innerHTML = msg;
      window.document.getElementById('history').appendChild(el);
      return false;
    };

    
    btn.onclick = function (){
      readTextFile("test_resources/mock_notification.json", function(text){
          socketClient.socket.send(text);
          var el = document.createElement('li');
          el.innerHTML = text;
          window.document.getElementById('history').appendChild(el);
      });
    }

    iBtn.onclick = function (){
      console.log("DDD")
      readTextFile("test_resources/invalid_multi_method_invoke.json", function(text){
        console.log(text)
          socketClient.socket.send(text);
          var el = document.createElement('li');
          el.innerHTML = text;
          window.document.getElementById('history').appendChild(el);
      });
    }

  }
);
