From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Fri, 17 Aug 2012 09:07:57 +0200
Subject: i.MX27 SLCDC driver
Message-ID: <502DEDCD.9050303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I would like to write the driver for SmartLCD controller of i.MX27. This 
kind of interface needs a LCD with an embedded graphic controller 
partially controlled by GPIO. I want to link it with an OLED DD12832.

How have I to write this driver : One driver for SLCDC and one driver 
for DD12832 ? How to link them together ?

Maybe use similar philosophy than soc-camera ?

I have written a driver for kernel 2.6.22 but SLCDC and DD12832 are in 
the same driver.

Thank you for your help.
Ga?tan Carlier

ps : I attach my previous driver for a better overview (this is a 
working draft for test purpose)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mx2fb-slcd_dd12832_oled.c
Type: text/x-csrc
Size: 35409 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/ea3df386/attachment-0001.bin>
