From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 03 Aug 2015 17:33:24 +0200
Subject: MAINTAINERS/s5p: Kamil Debski no longer with Samsung?
In-Reply-To: <1438548040.30149.1.camel@perches.com>
References: <20150802203128.1B6952691B2@smtprelay05.hostedemail.com>
 <1438548040.30149.1.camel@perches.com>
Message-ID: <5606140.737HZuKSvR@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Sunday, August 02, 2015 01:40:40 PM Joe Perches wrote:
> On Sun, 2015-08-02 at 20:31 +0000, Mail Delivery System wrote:
> > <k.debski@samsung.com>: host mailin.samsung.com[203.254.224.12] 
> > said: 550 5.1.1
> >     Recipient address rejected: User unknown (in reply to RCPT TO 
> > command)
> 
> His email address bounces.
> 
> Should MAINTAINERS be updated?

Please wait with these changes, the situation should be clarified soon
(I've added Kamil to Cc).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  MAINTAINERS | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 826affa..b5197c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1442,7 +1442,6 @@ F:        arch/arm/mach-s5pv210/
>  
>  ARM/SAMSUNG S5P SERIES 2D GRAPHICS ACCELERATION (G2D) SUPPORT
>  M:     Kyungmin Park <kyungmin.park@samsung.com>
> -M:     Kamil Debski <k.debski@samsung.com>
>  L:     linux-arm-kernel at lists.infradead.org
>  L:     linux-media at vger.kernel.org
>  S:     Maintained
> @@ -1450,7 +1449,6 @@ F:        drivers/media/platform/s5p-g2d/
>  
>  ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
>  M:     Kyungmin Park <kyungmin.park@samsung.com>
> -M:     Kamil Debski <k.debski@samsung.com>
>  M:     Jeongtae Park <jtp.park@samsung.com>
>  L:     linux-arm-kernel at lists.infradead.org
>  L:     linux-media at vger.kernel.org
> @@ -8248,9 +8246,8 @@ S:        Maintained
>  F:     drivers/media/usb/pwc/*
>  
>  PWM FAN DRIVER
> -M:     Kamil Debski <k.debski@samsung.com>
>  L:     lm-sensors at lm-sensors.org
> -S:     Supported
> +S:     Orphan
>  F:     Documentation/devicetree/bindings/hwmon/pwm-fan.txt
>  F:     Documentation/hwmon/pwm-fan
>  F:     drivers/hwmon/pwm-fan.c
> @@ -8906,9 +8903,8 @@ T:        https://github.com/lmajewski/linux-samsung-thermal.git
>  F:     drivers/thermal/samsung/
>  
>  SAMSUNG USB2 PHY DRIVER
> -M:     Kamil Debski <k.debski@samsung.com>
>  L:     linux-kernel at vger.kernel.org
> -S:     Supported
> +S:     Orphan
>  F:     Documentation/devicetree/bindings/phy/samsung-phy.txt
>  F:     Documentation/phy/samsung-usb2.txt
>  F:     drivers/phy/phy-exynos4210-usb2.c
