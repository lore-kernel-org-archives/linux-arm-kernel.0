From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 01 Dec 2017 14:04:33 +0100
Subject: [PATCH v2 05/11] ARM: dts: imx6dl: Remove unneeded label and
 unit address
In-Reply-To: <1511981684-13433-5-git-send-email-festevam@gmail.com>
References: <1511981684-13433-1-git-send-email-festevam@gmail.com>
 <1511981684-13433-5-git-send-email-festevam@gmail.com>
Message-ID: <1512133473.5918.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-11-29 at 16:54 -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove unneeded label and unit address in order to fix the following
> build warnings with W=1:
> 
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2000000/iomuxc-gpr at 20e0000/ipu1_csi0_mux at 34 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2000000/iomuxc-gpr at 20e0000/ipu1_csi1_mux at 34 has a unit name, but no
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
