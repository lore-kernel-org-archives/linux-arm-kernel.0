From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 9 Sep 2016 16:12:02 +0200
Subject: [PATCH 1/8] ARM: dts: bcm283x: Define standard pinctrl groups in
 the gpio node.
In-Reply-To: <1473411924.6698.85.camel@redhat.com>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
 <1473244289-20728-2-git-send-email-kraxel@redhat.com>
 <1628308726.55593.220fafc0-57d9-4317-a72d-0875dfb2d658.open-xchange@email.1und1.de>
 <1473411924.6698.85.camel@redhat.com>
Message-ID: <5ca1637e-58d8-fd04-416e-4619d99c4d12@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.09.2016 um 11:05 schrieb Gerd Hoffmann:
>   Hi,
>
>> According to this page [1] the pinctrl group for parallel display interface is
>> missing. Is it intended?
>>
>> [1] - http://elinux.org/RPi_BCM2835_GPIOs
> Just an oversight I guess.  Eric?
>
> Does this look correct?
>
> +                       dpi_gpio4: dpi_gpio4 {
> +                               brcm,pins = <4 5 6 7 8 9 10 11 12 13
> +                                            14 15 16 17 18 19 20 21
> +                                            22 23 24 25 26 27>;
> +                               brcm,function = <BCM2835_FSEL_ALT2>;
> +                       };

According to the wiki and the website [1] it starts at gpio 0

[1] -
https://www.raspberrypi.org/documentation/hardware/raspberrypi/dpi/README.md

>
> thanks,
>   Gerd
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
