From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jul 2015 21:57:08 +0800
Subject: [PATCH 1/3] ARM: dts: imx6qdl-sabrelite: Allow HDMI and LVDS to
 work simultaneously
In-Reply-To: <1435594615-9570-1-git-send-email-fabio.estevam@freescale.com>
References: <1435594615-9570-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150713135708.GR23464@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 01:16:53PM -0300, Fabio Estevam wrote:
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

Applied #1 and #2.  But #3 doesn't apply to my imx/dt branch.

Shawn
