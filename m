From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 16:49:57 +0800
Subject: [PATCH] ARM: dts: imx6dl: Fix gpt compatibles, remove imx6q-gpt
In-Reply-To: <1447224365-1210-1-git-send-email-mpa@pengutronix.de>
References: <1447224365-1210-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20151124084957.GR11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 07:46:05AM +0100, Markus Pargmann wrote:
> imx6qdl.dtsi uses compatibles "fsl,imx6q-gpt", "fsl,imx31-gpt".
> imx6dl.dtsi uses compatibles "fsl,imx6dl-gpt", "fsl,imx6q-gpt" since
> commit
> 
> 	4e415ed8143f (ARM: dts: imx6dl: add imx6dl gpt specific compatible string)
> 
> If imx6dl would be compatible with imx6q-gpt it would also have to be
> compatible with imx31-gpt which is currently missing.
> 
> Based on the above mentioned patch I assume imx6q-gpt and imx6dl-gpt are
> not compatible. So imx6q-gpt should be removed as compatible.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Applied, thanks.
