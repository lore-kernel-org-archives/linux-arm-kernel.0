From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 4 May 2016 11:53:50 -0700
Subject: [PATCH] ARM: BCM5301X: Add DT for Luxul XAP-1510
In-Reply-To: <1462296501-5209-1-git-send-email-dhaab@luxul.com>
References: <1462296501-5209-1-git-send-email-dhaab@luxul.com>
Message-ID: <572A453E.6010000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/16 10:28, Dan Haab wrote:
> Luxul XAP-1510 is an AP device based on BCM4708 SoC. It uses flash
> memory connected to the SPI controller.

Looks fine, except one nit:

> diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
> new file mode 100644
> index 0000000..f4460b5
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
> @@ -0,0 +1,67 @@
> +/*
> + * Broadcom BCM470X / BCM5301X ARM platform code.
> + * DTS for Luxul XAP-1510
> + *
> + * Copyright 2015 Luxul Inc.
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.

The ARM SoC maintainer have been asking to utilize a license which is
also BSD compatible, so something along the lines of this one:

arch/arm/boot/dts/bcm911360k.dts

Do you mind respining the patch to include that kind of license header?
Thanks!
-- 
Florian
