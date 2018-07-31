From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 31 Jul 2018 15:40:37 +0200
Subject: [PATCH] arm64: defconfig: Enable MFD_AXP20X_I2C
In-Reply-To: <20180731133828.2582-1-jagan@amarulasolutions.com>
References: <20180731133828.2582-1-jagan@amarulasolutions.com>
Message-ID: <20180731134036.mzgntiv6fwxg2vja@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 07:08:28PM +0530, Jagan Teki wrote:
> The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
> connected via I2C.
> 
> Enable the driver for this PMIC.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180731/ee18bbbe/attachment-0001.sig>
