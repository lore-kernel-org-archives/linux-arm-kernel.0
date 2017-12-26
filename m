From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Dec 2017 16:39:42 +0800
Subject: [PATCH 1/2] ARM: dts: ls1021a-qds: Remove extra clock cell
In-Reply-To: <1513697797-22724-1-git-send-email-fabio.estevam@nxp.com>
References: <1513697797-22724-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20171226083941.GI23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 01:36:36PM -0200, Fabio Estevam wrote:
> There is an extraneous '1' cell in the clock phandle, which causes
> the following build warning: 
> 
> arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): Property 'clocks', cell 1 is not a phandle reference in /soc/i2c at 2180000/mux at 77/i2c at 4/sgtl5000 at 2a
> arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller at 1400000 or bad phandle (referred from /soc/i2c at 2180000/mux at 77/i2c at 4/sgtl5000 at 2a:clocks[1])
> 
> Remove the unneeded extra cell.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
