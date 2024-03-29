var express = require('express');
var router = express.Router();
var mqttClient = require('./../mqttHelper.js');

router.get('/records/:id', (req, res) => {
    var body = {
        "patientId": req.params.id
      }
    mqttClient.handleRequest(req, res, 'toothtrek/record/get', req.params.id, body);
});

module.exports = router;