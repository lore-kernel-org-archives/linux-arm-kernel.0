From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 11 Sep 2009 14:54:32 +0200
Subject: Samsung S3C6410 / SmartQ / 2D acceleration / Xorg
In-Reply-To: <mailman.1325.1252670241.2256.linux-arm-kernel@lists.infradead.org>
References: <mailman.1325.1252670241.2256.linux-arm-kernel@lists.infradead.org>
Message-ID: <4AAA4888.9010107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Harald, I also have a working 2.6.31 port to the SmartQ Q7 at 
http://gitorious.org/mcuelenaere-smartq-kernel/mcuelenaere-smartq-kernel 
(this was based on the patch SmartDevices gave to the Mer team, see 
http://gitorious.org/mer-smartq/mer-smartq-kernel )
>> >  I have a fairly decent SmartQ5/7 config and mach-smartq init file.  Much of
>> >  this work (that I can test) can be back ported to the smdk6410 (that I can't
>> >  test.:-)
> So you're hacking on the SmartQ devices?  I recently discovered that they exist and I was
> very intrigued in buying one.
>
> Maybe you can tell me if you or anyone else in the community that is hacking on
> those devices have yet figured out
>
> 1) where the testpads/connector for the serial console is
> 2) where the testpads/connector for the JTAG console is
At least for the Q7, I can confirm there are RX, TX, 3V and GND pins on 
the board itself (haven't tested them, but I'm pretty sure those are the 
UART pins). Don't know about JTAG. I've done some documentation at 
http://wiki.maemo.org/Mer/Status/SmartQ7 wrt the hardware internals of 
the Q7. Regards, Maurus Cuelenaere

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090911/3259d32f/attachment-0001.htm>
