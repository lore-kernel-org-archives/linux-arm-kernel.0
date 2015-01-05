From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Jan 2015 21:10:02 +0800
Subject: [PATCH v2] ARM: dts: imx6qdl: Remove OCRAM clock from VPU node
In-Reply-To: <1418734961-4972-1-git-send-email-fabio.estevam@freescale.com>
References: <1418734961-4972-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150105131001.GC24511@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 11:02:41AM -0200, Fabio Estevam wrote:
> According to Documentation/devicetree/bindings/media/coda.txt:
> 
> - clock-names : Should be "ahb", "per"
> 
> The OCRAM clock is already provided inside the ocram node, so remove the OCRAM 
> clock from the VPU node.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
