From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 7 May 2018 08:39:32 +0200
Subject: [PATCH 1/2] ARM: dts: imx28-cfa10049: Remove unnecessary
 #address/#size-cells
In-Reply-To: <1525655020-31260-1-git-send-email-festevam@gmail.com>
References: <1525655020-31260-1-git-send-email-festevam@gmail.com>
Message-ID: <20180507063932.rz4v3pvgx64lfcd5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2018 at 10:03:39PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove unnecessary #address-cells/#size-cells to fix the following
> DTC warnings:
> 
> arch/arm/boot/dts/imx28-cfa10049.dtb: Warning (avoid_unnecessary_addr_size): /gpio_keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180507/3cafc633/attachment.sig>
