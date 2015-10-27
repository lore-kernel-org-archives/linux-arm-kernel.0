From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 27 Oct 2015 22:14:13 +0100
Subject: [PATCH v7 09/17] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <1445655964-15237-4-git-send-email-ykk@rock-chips.com>
References: <1445599415-30856-1-git-send-email-ykk@rock-chips.com>
 <1445655964-15237-1-git-send-email-ykk@rock-chips.com>
 <1445655964-15237-4-git-send-email-ykk@rock-chips.com>
Message-ID: <7020871.rDEeBYHTDp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch subject should probably be something like:

dt-bindings: add document for rockchip variant of analogix_dp

or similar, but definitly should mention that it's the Rockchip variant.


Am Samstag, 24. Oktober 2015, 11:06:03 schrieb Yakir Yang:
> Rockchip DP driver is a helper driver of analogix_dp coder driver,
> so most of the DT property should be descriped in analogix_dp document.
> 
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

everything else looks nice, so with a better subject

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
