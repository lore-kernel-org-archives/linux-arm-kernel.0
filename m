From: elder@ieee.org (Alex Elder)
Date: Thu, 13 Mar 2014 16:05:49 -0500
Subject: [PATCH 0/6] ARM: BCM63XX: add support for BCM63138 SoC
In-Reply-To: <CAJiQ=7BrCqo3VijjEvt2JLifM0MNGYmAA+VG_YQbSHfyBqsbtg@mail.gmail.com>
References: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
 <53193FEE.4060002@ieee.org>
 <CAJiQ=7BrCqo3VijjEvt2JLifM0MNGYmAA+VG_YQbSHfyBqsbtg@mail.gmail.com>
Message-ID: <53221DAD.4010708@ieee.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2014 10:44 PM, Kevin Cernekee wrote:
> On Thu, Mar 6, 2014 at 7:41 PM, Alex Elder <elder@ieee.org> wrote:
>>> This patchset adds very minimal support for the BCM63138 SoC which is
>>> a xDSL SoC using a dual Cortex A9 CPU complex.
>>
>>
>> Why do you use "63xx" for the generic name, when the specific
>> part you are defining here is 63138?  I would have expected
>> "63xxx".
> 
> The product line has a mix of 4-digit and 5-digit part numbers.  The
> drivers for onchip peripherals all used "bcm63xx":

That's too bad.  I would suggest that one or the other be used
consistently, apparently "63xx" (not 63xxx) would be it.

					-Alex

> $ find drivers/ | grep 63xx
> drivers/tty/serial/bcm63xx_uart.c
> drivers/pcmcia/bcm63xx_pcmcia.h
> drivers/pcmcia/bcm63xx_pcmcia.c
> drivers/usb/gadget/bcm63xx_udc.c
> drivers/watchdog/max63xx_wdt.c
> drivers/watchdog/bcm63xx_wdt.c
> drivers/char/hw_random/bcm63xx-rng.c
> drivers/mtd/bcm63xxpart.c
> drivers/net/phy/bcm63xx.c
> drivers/net/ethernet/broadcom/bcm63xx_enet.h
> drivers/net/ethernet/broadcom/bcm63xx_enet.c
> drivers/spi/spi-bcm63xx.c
> drivers/spi/spi-bcm63xx-hsspi.c
> 
