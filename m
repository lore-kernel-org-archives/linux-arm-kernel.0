From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Tue, 07 Feb 2012 17:10:52 +0100
Subject: Kirkwood, kernel 3.2, vmalloc region overlap, not starting up
In-Reply-To: <20120207152903.GA16238@lunn.ch>
References: <20120207152903.GA16238@lunn.ch>
Message-ID: <4F314D0C.50501@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.02.2012 16:29, schrieb Andrew Lunn:
> Hi Nils
Hey Andrew!

> There was a thread a while back about CONFIG_ARM_PATCH_PHYS_VIRT
> causing problem with some kirkwood boards. Maybe try disabling this
> and set CONFIG_PHYS_OFFSET=0x0.
> 
> However, it could be a different problem...

Nope, nothing elese, it worked exactly as you described it!
(Though it took me some minutes to find the options in menuconfig).

Here it is happily up again:

root at tk71:~# uname -a
Linux tk71 3.2.0-00012-g980d683-dirty #31 Tue Feb 7 17:04:50 CET 2012
armv5tel GNU/Linux


Thanks a million!
Should we ever meet in person - I now officially owe you a beer (or
other drink at your choice :)

Apart from my joy - the basic reason for that change would be still
interesting? Does this only apply to Kirwoods or my special board?

> 	 Andrew
Thanks again!
Cheers
  nils

-- 
kernel concepts GbR      Tel: +49-271-771091-12
Sieghuetter Hauptweg 48  Fax: +49-271-771091-19
D-57072 Siegen           Mob: +49-176-21024535
http://www.kernelconcepts.de
