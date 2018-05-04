From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 4 May 2018 15:28:37 +0800
Subject: [PATCH] arm64: dts: ls208xa-rdb: Pass unit name to SPI flash node
In-Reply-To: <1524601644-23607-1-git-send-email-festevam@gmail.com>
References: <1524601644-23607-1-git-send-email-festevam@gmail.com>
Message-ID: <20180504072836.GV3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 05:27:24PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Pass unit name to SPI flash node to match its 'reg' value and
> also avoid the following DTC warnings:
> 
> arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: Warning (unit_address_vs_reg): /soc/dspi at 2100000/n25q512a: node has a reg or ranges property, but no unit name
> arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: Warning (unit_address_vs_reg): /soc/dspi at 2100000/n25q512a: node has a reg or ranges property, but no unit name
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
