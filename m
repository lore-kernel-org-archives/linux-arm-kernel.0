From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 1 Jul 2018 21:30:02 +0800
Subject: [PATCH v2] ARM: dts: imx53-qsb: Let the codec control MCLK pinctrl
In-Reply-To: <1530059662-20589-1-git-send-email-festevam@gmail.com>
References: <1530059662-20589-1-git-send-email-festevam@gmail.com>
Message-ID: <20180701133000.GT4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 09:34:22PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The hog pinctrl hog is meant for pins that do not have an
> associated driver.
> 
> The MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK pin is the one that
> provides the MCLK signal to the SGTL5000 codec, so a
> better represenation is to move it under the codec node.
> 
> While at it, change the pinctrl value from 0x80000000 to the
> POR reset value of register IOMUXC_SW_PAD_CTL_PAD_GPIO_0.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
