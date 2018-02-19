From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 19 Feb 2018 14:49:28 +0100
Subject: [PATCH v5 05/12] drm/bridge/synopsys: dw-hdmi: don't clobber
 drvdata
In-Reply-To: <20180214200906.31509-6-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
 <20180214200906.31509-6-jernej.skrabec@siol.net>
Message-ID: <1519048168.3408.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-02-14 at 21:08 +0100, Jernej Skrabec wrote:
> dw_hdmi shouldn't set drvdata since some drivers might need to store
> it's own data there. Rework dw_hdmi in a way to return struct dw_hdmi
> instead to store it in drvdata. This way drivers are responsible to
> store and pass structure when needed.
> 
> Idea was taken from the following commit:
> 8242ecbd597d ("drm/bridge/synopsys: stop clobbering drvdata")
> 
> Cc: p.zabel at pengutronix.de
> Cc: narmstrong at baylibre.com
> Cc: Laurent.pinchart at ideasonboard.com
> Cc: hjc at rock-chips.com
> Cc: heiko at sntech.de
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

For i.MX:
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
