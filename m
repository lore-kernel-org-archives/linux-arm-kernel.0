From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 16 Nov 2016 17:36:44 +0100 (CET)
Subject: [PATCH 2/2] ARM: bcm2835: Add names for the Raspberry Pi Zero
 GPIO lines
In-Reply-To: <87zil0r71o.fsf@eliezer.anholt.net>
References: <1479060729-25769-1-git-send-email-stefan.wahren@i2se.com>
 <1479060729-25769-3-git-send-email-stefan.wahren@i2se.com>
 <87zil0r71o.fsf@eliezer.anholt.net>
Message-ID: <1948397903.180831.e7d7379f-2688-45de-8e73-a2f866d7cd9c.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Eric Anholt <eric@anholt.net> hat am 15. November 2016 um 18:23 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > This adds the GPIO names for the Raspberry Pi Zero. Since there are no
> > schematics for the RPi Zero use the same as the Model A+.
> 
> These look good to me. I don't have a Zero schematic, but I compared to
> dt-blob.
> 
> I've pulled these two to -next.

Thanks. Unfortunately the link to the dt-blob is outdated. The newer ones [1]
contains the definition of the Raspberry Pi Zero and it differs from Model A+

Please drop the complete series and i'll send a V2. Sorry about this.

[1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts

Stefan
