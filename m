From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 03 Sep 2012 22:45:11 +0200
Subject: [PATCH 0/3] gpio-twl4030: add new device tree properties
In-Reply-To: <5044BE79.4040100@ti.com>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
 <5044BE79.4040100@ti.com>
Message-ID: <504516D7.3060101@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

> Nit #2: the DTS file does not belong to the gpio subsystem. So you
> should prefix them using the *convention* for ARM DTS patches:
>
> arm/dts: omap3: Add gpio-twl4030 properties for BeagleBoard and omap3-EVM
>
> Or maybe "ARM: dts: " because it looks like most people are using that
> nowadays.
>
> The convention for the gpio directory is similar:
> gpio/twl4030: get platform data from device tree
>
>>    gpio-twl4030: updates the bindings for new dt properties
>>
>>   .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
>>   arch/arm/boot/dts/omap3-beagle.dts                 |   20 +++++
>>   arch/arm/boot/dts/omap3-evm.dts                    |   13 +++
>>   drivers/gpio/gpio-twl4030.c                        |   86 +++++++++++++------
>>   4 files changed, 98 insertions(+), 27 deletions(-)
> Thanks,
> Benoit
>
Thank you for your review, I will send a new version soon.

Regards,
Florian
