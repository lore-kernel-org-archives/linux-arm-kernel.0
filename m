From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 20 May 2018 13:48:39 +0200
Subject: [PATCH 2/3] drm/rockchip: lvds: avoid duplicating
 drm_bridge_attach
In-Reply-To: <20180502074025.12421-3-peda@axentia.se>
References: <20180502074025.12421-1-peda@axentia.se>
 <20180502074025.12421-3-peda@axentia.se>
Message-ID: <2076868.NHBhtu2M9j@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 2. Mai 2018, 09:40:24 CEST schrieb Peter Rosin:
> drm_bridge_attach takes care of these assignments, so there is no need
> to open-code them a second time.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

applied to drm-misc-next


Thanks
Heiko
