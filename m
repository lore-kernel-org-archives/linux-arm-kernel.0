From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 8 Sep 2016 14:06:52 +0200
Subject: [PATCH 4/8] ARM: dts: bcm283x: Add a new EMMC pin group from the
 downstream tree.
In-Reply-To: <1473320687.6698.25.camel@redhat.com>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
 <1473244289-20728-5-git-send-email-kraxel@redhat.com>
 <87650770.23554.026b1e4b-e35d-48e6-9394-7eeea0ff9add.open-xchange@email.1und1.de>
 <1473320687.6698.25.camel@redhat.com>
Message-ID: <429647ef-ff1e-4999-5b19-3b4529ad3872@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.09.2016 um 09:44 schrieb Gerd Hoffmann:
> On Mi, 2016-09-07 at 20:13 +0200, Stefan Wahren wrote:
>>> Gerd Hoffmann <kraxel@redhat.com> hat am 7. September 2016 um 12:31
>>> geschrieben:
>>>
>>>
>>> From: Eric Anholt <eric@anholt.net>
>>>
>>> This will be used for having EMMC (sdhci-bcm2835.c) drive the
>>> wireless.
>> sdhci-bcm2835.c has been replaced by sdhci-iproc.c
> Ah, right, I'll update the commit msg for v2.
>
>> How about adding pull defines to include/dt-bindings/pinctrl/bcm2835.h?
> Already there (or do you mean something other than '#define
> BCM2835_FSEL_*' ?)

No, i thought of the GPIO pull up/down register values:

BCM2835_PUD_OFF 0
BCM2835_PUD_DOWN 1
BCM2835_PUD_UP 2

>
> cheers,
>   Gerd
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
