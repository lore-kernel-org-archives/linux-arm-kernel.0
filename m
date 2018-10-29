From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 09:11:52 +0100
Subject: [PATCH v2] arm64: defconfig: Enable MFD_AXP20X_I2C
In-Reply-To: <20181025150659.19657-1-jagan@amarulasolutions.com>
References: <20181025150659.19657-1-jagan@amarulasolutions.com>
Message-ID: <20181029081151.pvx5mrvngzv26agg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 08:36:59PM +0530, Jagan Teki wrote:
> The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
> connected via I2C.
> 
> Enable the driver for this PMIC.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Tested-by: Jagan Teki <jagan@amarulasolutions.com> # OPI-1+

Queued for 4.21

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/7f0a4738/attachment.sig>
