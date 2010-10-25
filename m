From: prymka.wieslaw@gmx.de (Wieslaw Prymka)
Date: Mon, 25 Oct 2010 22:10:29 +0200
Subject: Smargo Cardreader problem with QNAP-TS119(2.6.32-5-kirkwood)
Message-ID: <000001cb7480$ac8da130$05a8e390$@wieslaw@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

 

I have a problem with Smargo Cardreader on my debian qnap-119

 

 

[203924.885817] ftdi_sio 1-1.3:1.0: FTDI USB Serial Device converter
detected

[203924.893436] usb 1-1.3: Detected FT232BM

[203924.897379] usb 1-1.3: Number of endpoints 2

[203924.901827] usb 1-1.3: Endpoint 1 MaxPacketSize 64

[203924.906727] usb 1-1.3: Endpoint 2 MaxPacketSize 64

[203924.911640] usb 1-1.3: Setting MaxPacketSize 64

[203924.917559] ftdi_sio ttyUSB0: Unable to read latency timer: -32

[203924.924186] usb 1-1.3: FTDI USB Serial Device converter now attached to
ttyUSB0

 

 

I think this is the problem:

 

 

203924.917559] ftdi_sio ttyUSB0: Unable to read latency timer: -32

 

 

the Smargo is attached on ttyUSB0, but ........

 

 

2010/10/18  8:00:45 r 41035470 ERROR opening device /dev/ttyUSB0

2010/10/18  8:00:45 r 41035470 Cannot open device: /dev/ttyUSB0

 

 

any idea ?

 

 

 

 

Best regards

Wiesiek

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101025/c98da336/attachment-0001.html>
