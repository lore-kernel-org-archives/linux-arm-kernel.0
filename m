From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 30 Jun 2015 11:40:30 +0200
Subject: [PATCH 1/3] ARM: dts: imx6qdl-sabrelite: Allow HDMI and LVDS to
 work simultaneously
In-Reply-To: <1435594615-9570-1-git-send-email-fabio.estevam@freescale.com>
References: <1435594615-9570-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1435657230.13470.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 29.06.2015, 13:16 -0300 schrieb Fabio Estevam:
> Currently it is not possible to have HDMI and LVDS working simultaneously,
> because both ports try to use PLL5.
> 
> Move the LVDS clock parent to PLL3_USB_OTG, so that HDMI and LVDS can be
> driven from independent sources.
> 
> With this change the LDB pixel clock goes to 68.57 MHz, which is still
> within the valid range for the HSD100PXN1 LVDS panel.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

All three
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
