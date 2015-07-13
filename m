From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jul 2015 16:39:20 +0800
Subject: [PATCH v3 1/2] ARM: dts: imx6qdl-sabresd: Allow HDMI and LVDS to
 work simultaneously
In-Reply-To: <1435338654-9098-1-git-send-email-fabio.estevam@freescale.com>
References: <1435338654-9098-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150713083919.GN23464@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 02:10:53PM -0300, Fabio Estevam wrote:
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
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied both, thanks.
