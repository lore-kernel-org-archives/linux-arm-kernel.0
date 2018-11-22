From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Nov 2018 09:19:09 +0100
Subject: [PATCH v1 1/2] ARM: dts: sun8i: Add board dts file for
 t3-cqa3t-bv3.
In-Reply-To: <20181121154356.GA4359@arx-s1>
References: <20181121154356.GA4359@arx-s1>
Message-ID: <20181122081909.2u3kt3ih5ma2dl2y@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 11:43:57PM +0800, Hao Zhang wrote:
> The T3/R40/V40 using the same sdk and config file in allwinner
> sdk, it seem they are the same SOC just with different name, so
> compatible with R40.
> 
> The t3-cqa3t-bv3 based on Allwinner T3 SoC, it has various connectors,
> leds, buttons, and sell on:
> https://item.taobao.com/item.htm?spm=2013.1.w4023-4203040713.25.62704cce7UCgLS&id=557154455330
> 
> It features:
>  - X-Powers AXP221s PMIC connected to i2c0
>  - 1/2 GB DDR3 DRAM
>  - 8 GB eMMC
>  - 2x USB 2.0 hosts
>  - 1x USB 2.0 OTG
>  - 2 LVDS connectors
>  - 24 bit RGB LCD connector
>  - HDMI output
>  - DVP camera interface (support 500w cmos camera)
>  - GPIO connectors
>  - 5 TTL uarts and 2 RS232 uarts
>  - 1 RS485 connector
>  - support i2c capacitive tp and usb infrared tp
>  - boot control, reset and user buttons
>  - 3.5mm headphone and 3.5mm mic jack
>  - 100M RJ45
>  - micro SD card slot
>  - DC power jack
>  - RCT power slot
>  - 1 CVBS TVIN
>  - 1 CVBS TVOUT
>  - 2 customer leds
>  - 1 buzzer
>  - 1 minipcie
>  - I2C output
>  - SPI output
>  - PCM output
>  - wifi and bt connector reserved.
> 
> Board info can find here:
> https://github.com/Axl-zhang/Allwinner-V40-T3-R40-manual
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>

Applied both patches, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181122/cb08f546/attachment.sig>
