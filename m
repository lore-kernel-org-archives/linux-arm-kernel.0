From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 29 Oct 2016 14:15:24 +0200 (CEST)
Subject: [PATCH v3] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <20161027165246.23936-1-eric@anholt.net>
References: <20161027165246.23936-1-eric@anholt.net>
Message-ID: <2009597620.98560.11cdcb7c-b46d-43f0-a853-b742fde3546a.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 27. Oktober 2016 um 18:52 geschrieben:
> 
> 
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The idea is to give useful names to GPIO lines that an implementer
> will be using from userspace, e.g. for maker type projects.  These are
> user-visible using tools/gpio/lsgpio.c

sorry for the late feedback, but did you check your patch against the Firmware
DTS [1]?

As an example the GPIO38 is connected and named as USB_LIMIT_1A2 since Raspberry
Pi 1 B Plus.

[1] -
https://github.com/raspberrypi/documentation/blob/master/configuration/images/dt-blob.dts
