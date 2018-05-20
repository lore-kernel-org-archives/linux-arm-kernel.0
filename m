From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 20:23:54 +0800
Subject: [PATCH v2] ARM: dts: imx6/7: Remove unit-address from anatop
 regulators
In-Reply-To: <1526304714-23821-1-git-send-email-festevam@gmail.com>
References: <1526304714-23821-1-git-send-email-festevam@gmail.com>
Message-ID: <20180520122353.GT26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:31:54AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove unit-address and reg property from anatop regulators to fix
> the following DTC warnings with W=1:
> 
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unique_unit_address): /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddcore at 20c8140: duplicate unit-address (also used in node /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddpu at 20c8140)
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unique_unit_address): /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddcore at 20c8140: duplicate unit-address (also used in node /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddsoc at 20c8140)
> arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unique_unit_address): /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddpu at 20c8140: duplicate unit-address (also used in node /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddsoc at 20c8140)
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
