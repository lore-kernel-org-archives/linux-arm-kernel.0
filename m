From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 2 Feb 2017 10:50:03 +0100
Subject: [RESENT PATCH] ARM: bcm2835: Add devicetree for the Raspberry Pi
 3, for arm (32)
In-Reply-To: <1486024672.11636.1.camel@crowfest.net>
References: <1484845444-4617-1-git-send-email-kraxel@redhat.com>
 <87fukcgsqp.fsf@eliezer.anholt.net> <878tpqki0k.fsf@eliezer.anholt.net>
 <1485944672.1076.50.camel@redhat.com> <1485951653.1076.54.camel@redhat.com>
 <1486024672.11636.1.camel@crowfest.net>
Message-ID: <3b3ffeb9-6e92-114c-8fdc-9586bdc68373@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.02.2017 um 09:37 schrieb Michael Zoran:
> This is actually a problem I had to deal with way in the begging of
> ARM64.  What was done in the github tree was to have the one of the DTS
>   files(in this case 64) #include the 32 bit dts.  That way it's not
> needed to have the symbolic link and install should work.
>
> I know it's ulgy, but it works...
>
> Take a look at:
> https://github.com/raspberrypi/linux/blob/rpi-4.10.y/arch/arm64/boot/dt
> s/broadcom/bcm2710-rpi-3-b.dts
>
> Here is what the file contains:
> #define RPI364
>
> #include "../../../../arm/boot/dts/bcm2710-rpi-3-b.dts"
>
>
>

This do not work in the context of the split device-tree repository [0] 
(where the directory structure differs).

[0] 
https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/
