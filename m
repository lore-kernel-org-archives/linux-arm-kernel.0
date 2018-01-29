From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Jan 2018 14:36:29 +0800
Subject: [PATCH 1/2] ARM: dts: imx27-eukrea-mbimxsd27-baseboard: Pass
 missing unit address
In-Reply-To: <1514391804-9518-1-git-send-email-festevam@gmail.com>
References: <1514391804-9518-1-git-send-email-festevam@gmail.com>
Message-ID: <20180129063628.GB26461@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 02:23:23PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> ads7846 is connected to SPI chip select 0, so pass the unit address
> accordingly to fix the following build warning with W=1:
> 
> arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb: Warning (unit_address_vs_reg): Node /soc/aipi at 10000000/cspi at 1000e000/ads7846 has a reg or ranges property, but no unit name
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
