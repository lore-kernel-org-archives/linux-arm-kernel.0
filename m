From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Aug 2018 09:21:52 +0800
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Add MC13892 ADC support
In-Reply-To: <1532621122-22013-1-git-send-email-fabio.estevam@nxp.com>
References: <1532621122-22013-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20180827012151.GB29208@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:05:21PM -0300, Fabio Estevam wrote:
> The MC13892 Analog-to-Digital input pins (ADIN5-7) are exposed on the
> imx51-babbage board.
> 
> Pass the "fsl,mc13xxx-uses-adc" property so that the MC13892 ADC
> block can work.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
