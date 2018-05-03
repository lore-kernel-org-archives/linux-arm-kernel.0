From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 3 May 2018 09:05:12 +0800
Subject: [PATCH 1/5] ARM: dts: imx6qdl: Remove #address/#size-cells from
 mipi_dsi
In-Reply-To: <1524491174-16878-1-git-send-email-festevam@gmail.com>
References: <1524491174-16878-1-git-send-email-festevam@gmail.com>
Message-ID: <20180503010510.GM3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 10:46:10AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove unnecessary #address-cells/#size-cells to fix the following
> DTC warnings:
> 
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (avoid_unnecessary_addr_size): /soc/aips-bus at 2100000/mipi at 21e0000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
