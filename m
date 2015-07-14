From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Jul 2015 11:39:45 +0800
Subject: [PATCH v4] ARM: dts: imx6qdl-sabreauto: Allow HDMI and LVDS to
 work simultaneously
In-Reply-To: <1436803385-11025-1-git-send-email-fabio.estevam@freescale.com>
References: <1436803385-11025-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150714033945.GD4119@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:03:05PM -0300, Fabio Estevam wrote:
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

Applied, thanks.
