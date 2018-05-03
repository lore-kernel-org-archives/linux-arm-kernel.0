From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 3 May 2018 11:30:57 +0800
Subject: [PATCH 1/5] ARM: dts: imx53-ppd: Remove unnecessary
 #address/#size-cells
In-Reply-To: <1524513033-21136-1-git-send-email-festevam@gmail.com>
References: <1524513033-21136-1-git-send-email-festevam@gmail.com>
Message-ID: <20180503033056.GR3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 04:50:29PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove unnecessary #address-cells/#size-cells to fix the following
> DTC warnings:
> 
> arch/arm/boot/dts/imx53-ppd.dtb: Warning (avoid_unnecessary_addr_size): /power-gpio-keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> arch/arm/boot/dts/imx53-ppd.dtb: Warning (avoid_unnecessary_addr_size): /touch-lock-key: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
