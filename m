From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 13 Jan 2018 11:57:02 +0100 (CET)
Subject: bcm2835: device tree regression in 4.15.0-rc7
In-Reply-To: <6809C455-9989-409C-9AB8-DDA8FDD04EB3@martin.sperl.org>
References: <6809C455-9989-409C-9AB8-DDA8FDD04EB3@martin.sperl.org>
Message-ID: <826239869.43494.1515841022132@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

> kernel at martin.sperl.org hat am 13. Januar 2018 um 11:05 geschrieben:
> 
> 
> Hi!
> ...
> 
> and network does not
> come up so ssh access is not possible?
> DHCP-Networking does not come up either!
> 
> After reapplying the patch for CM3-dt and rebuilding it boots fine.
> 
> As far as I understand older, formerly functional DTs should always continue to work.

please apply "drm/vc4: Move IRQ enable to PM path" to get the rid off this warning and
"phy: work around 'phys' references to usb-nop-xceiv devices" to fix dwc2.

Stefan


> 
> Martin
>
