From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 21 Dec 2017 15:41:12 +0800
Subject: [PATCH v2 01/12] ARM: dts: imx51-ts4800: Fix syscon and
 touschscreen nodes
In-Reply-To: <1512390016-703-1-git-send-email-festevam@gmail.com>
References: <1512390016-703-1-git-send-email-festevam@gmail.com>
Message-ID: <20171221074111.GD23230@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 10:20:05AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The syscon node has an incorrect notation for its unit address and the
> wdt node has an unneeded unit address.
> 
> Fix them so that the following build warnings with W=1 are gone:
> 
> arch/arm/boot/dts/imx51-ts4800.dtb: Warning (unit_address_vs_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/syscon at b0010000/wdt at e has a unit name, but no reg property
> arch/arm/boot/dts/imx51-ts4800.dtb: Warning (unit_address_vs_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/touchscreen has a reg or ranges property, but no unit name
> arch/arm/boot/dts/imx51-ts4800.dtb: Warning (simple_bus_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/syscon at b0010000 simple-bus unit address format error, expected "10000"
> arch/arm/boot/dts/imx51-ts4800.dtb: Warning (simple_bus_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/touchscreen simple-bus unit address format error, expected "12000"
> 
> Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> Reviewed-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Applied all, thanks.
