From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 6 Nov 2015 20:44:24 -0200
Subject: [PATCH 3/3] ARM: dts: imx: ventana: Allow HDMI and LVDS to work
 simultaneously
In-Reply-To: <1446849632-20333-4-git-send-email-tharvey@gateworks.com>
References: <1446849632-20333-1-git-send-email-tharvey@gateworks.com>
 <1446849632-20333-4-git-send-email-tharvey@gateworks.com>
Message-ID: <CAOMZO5ASb7n-xKvvys3RQ3hDtb05mqdeaQZvgD+Ski-Rsy=XiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 6, 2015 at 8:40 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> Currently it is not possible to have HDMI and LVDS working simultaneously,
> because both ports try to use PLL5.
>
> Move the LVDS clock parent to PLL3_USB_OTG, so that HDMI and LVDS can be
> driven from independent sources.
>
> With this change the LDB pixel clock goes to 68.57 MHz, which is still
> within the valid range for the displays supported by the Ventana boards.
>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
