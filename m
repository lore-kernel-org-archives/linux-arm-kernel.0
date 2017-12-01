From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 01 Dec 2017 14:05:20 +0100
Subject: [PATCH v2 04/11] ARM: dts: imx6dl: Pass the reg properties for
 mipi nodes
In-Reply-To: <1511981684-13433-4-git-send-email-festevam@gmail.com>
References: <1511981684-13433-1-git-send-email-festevam@gmail.com>
 <1511981684-13433-4-git-send-email-festevam@gmail.com>
Message-ID: <1512133520.5918.14.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-11-29 at 16:54 -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Pass the reg properties for mipi nodes in order to fix the
> following build warnings with W=1:
> 
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 1/endpoint at 0 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 1/endpoint at 1 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 2/endpoint at 0 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 2/endpoint at 1 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 3/endpoint at 0 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 3/endpoint at 1 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 4/endpoint at 0 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 4/endpoint at 1 has a unit name, but no reg property
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
