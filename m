From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 May 2018 13:46:24 +0800
Subject: [PATCH 1/2] ARM: dts: imx28-cfa10049: Remove unnecessary
 #address/#size-cells
In-Reply-To: <1525655020-31260-1-git-send-email-festevam@gmail.com>
References: <1525655020-31260-1-git-send-email-festevam@gmail.com>
Message-ID: <20180511054623.GA26863@dragon>
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

Applied both, thanks.
