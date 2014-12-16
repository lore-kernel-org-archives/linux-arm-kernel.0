From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 16 Dec 2014 14:24:20 +0100
Subject: [PATCH v2] ARM: dts: imx6qdl: Remove OCRAM clock from VPU node
In-Reply-To: <1418734961-4972-1-git-send-email-fabio.estevam@freescale.com>
References: <1418734961-4972-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1418736260.3374.60.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am Dienstag, den 16.12.2014, 11:02 -0200 schrieb Fabio Estevam:
> According to Documentation/devicetree/bindings/media/coda.txt:
> 
> - clock-names : Should be "ahb", "per"
> 
> The OCRAM clock is already provided inside the ocram node, so remove the OCRAM 
> clock from the VPU node.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
