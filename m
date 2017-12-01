From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Fri, 1 Dec 2017 14:45:16 -0500
Subject: [PATCH 01/12] ARM: dts: imx51-ts4800: Fix syscon and
 touschscreen nodes
In-Reply-To: <1512156285-18451-1-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
Message-ID: <20171201194516.ix2oa7waxy5ph55s@workotop.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 01, 2017 at 05:24:34PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The syscon node has an incorrect notation for its unit address and the
> wdt node has an unneeded unit address.
> 
> Fix them so that the following build warnings with W=1 are gone:
> 
> arch/arm/boot/dts/imx51-ts4800.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> arch/arm/boot/dts/imx51-ts4800.dtb: Warning (unit_address_vs_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/syscon at b0010000/wdt at e has a unit name, but no reg property
> arch/arm/boot/dts/imx51-ts4800.dtb: Warning (unit_address_vs_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/touchscreen has a reg or ranges property, but no unit name
> arch/arm/boot/dts/imx51-ts4800.dtb: Warning (simple_bus_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/syscon at b0010000 simple-bus unit address format error, expected "10000"
> arch/arm/boot/dts/imx51-ts4800.dtb: Warning (simple_bus_reg): Node /soc/aips at 80000000/weim at 83fda000/fpga at 0/touchscreen simple-bus unit address format error, expected "12000"
> 
> Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Changes are fine to me, thank you for fixing the warnings. I don't know
what the rule is and if I should reply with a tag like Reviewed-by or
anything else, please let me know.

-- 
Damien
