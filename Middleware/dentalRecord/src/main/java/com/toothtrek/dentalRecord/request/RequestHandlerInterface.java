package com.toothtrek.dentalRecord.request;

import org.eclipse.paho.mqttv5.common.MqttMessage;

public interface RequestHandlerInterface {
    // Reminder to add 'synchronized' keyword to handle methods that requires it.
    // (e.g. creations)
    public void handle(MqttMessage message);
}