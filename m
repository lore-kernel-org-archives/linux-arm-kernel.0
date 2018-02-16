From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 16 Feb 2018 08:03:59 +0100
Subject: [PATCH v5 05/12] drm/bridge/synopsys: dw-hdmi: don't clobber
 drvdata
In-Reply-To: <20180214200906.31509-6-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
 <20180214200906.31509-6-jernej.skrabec@siol.net>
Message-ID: <5806685.TbOkgmbs60@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 14. Februar 2018, 21:08:59 CET schrieb Jernej Skrabec:
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

For the Rockchip-part
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>
