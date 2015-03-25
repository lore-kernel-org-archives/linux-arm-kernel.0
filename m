From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 25 Mar 2015 17:51:57 +0100
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <2619686.csNBBFyt8W@phil>
References: <4184159.j0iXe39dFB@phil> <2619686.csNBBFyt8W@phil>
Message-ID: <1427302317.3441.65.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 23.03.2015, 19:17 +0100 schrieb Heiko Stuebner:
> Hi Philipp,
> 
> Am Donnerstag, 12. M?rz 2015, 21:45:19 schrieb Heiko Stuebner:
> > At least the Rockchip variant of the dw_hdmi can have controllable power
> > supplies providing 1.0 and 1.8V. Therefore add the possibility for the
> > generic bridge driver to enable supplies provided by the hw-specific
> > drivers.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> does this look ok now?

Yes, thank you.
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

> And as we talked about in Chemnitz, who will be taking such bridge-related 
> changes, as you mentioned some last bridge-patches going through Thierry.

Indeed, recent drm/bridge fixes were merged through the drm/panel tree.
Thierry, will you continue to do that or should I collect the dw_hdmi
patches?

regards
Philipp
