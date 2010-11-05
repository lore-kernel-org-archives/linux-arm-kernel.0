From: rje@crystalfontz.com (Rob Emanuele)
Date: Fri, 5 Nov 2010 14:09:21 -0700
Subject: at91sam9g45 USB OTG support?
Message-ID: <AANLkTi=8-nOGxLOw-Thvc7WaKwMg2cyC3h01SF0kZFL7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

We've been developing a at91sam9g45 product and it is finally available at:
https://www.crystalfontz.com/product/CFA910.html

We are looking into supporting USB OTG on this device as the 'g45 has
the USB host/device port.  As far at I can tell Atmel or anyone else
working on this platform has not made full use of this as an OTG
device.  I haven't found support in the USB or the OTG code for
reading the USB ID line to determine host or device mode.

Am I missing something or is that an area that needs some code written for it?

Thank you,

Rob
--
Robert Emanuele
Crystalfontz America, Inc.
www.crystalfontz.com
rje at crystalfontz.com
+1 509 892 1200
