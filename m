From: ratheendran.s@gmail.com (Ravi)
Date: Sat, 18 Jun 2011 04:52:57 +0000 (UTC)
Subject: USB serial Gadget is not working under WindowsXp
Message-ID: <loom.20110618T063246-131@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dear All,

I want to make the USB Gadget to work as a serial port,for this I enabled the
the following in the kernel menuconfig.

*** USB Device Class drivers***
  <*>   USB Modem (CDC ACM) support 
      <*>   USB Gadget Support  ---> 
     <M>   USB Gadget Drivers     
     <M>   Serial Gadget (with CDC ACM and CDC OBEX support)  
       
For this configuration I am able to get the serial Interface on the Linux host
machine , In widows Xp machine I am facing the driver loading issue.

I have followed all the steps mentioned in the
"Documentation/usb/gadget_serial.txt" document.

Please help me in fixing this issue.

Ravi
