From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 Oct 2017 23:29:07 +0200
Subject: [PATCH v2 2/4] clk: rockchip: export clock pclk_efuse_256 for
 RK3368 SoCs
In-Reply-To: <20170904085119.25981-3-romain.perier@collabora.com>
References: <20170904085119.25981-1-romain.perier@collabora.com>
 <20170904085119.25981-3-romain.perier@collabora.com>
Message-ID: <2959871.y9lmPDGV1V@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 4. September 2017, 10:51:17 CEST schrieb Romain Perier:
> This exports the clock for the pclk gate of the eFuse that is part of
> the RK3368 SoCs. So we can use it from the dt-bindings.
> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>

applied for 4.15


Thanks
Heiko
