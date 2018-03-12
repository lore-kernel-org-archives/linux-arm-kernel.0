From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 Mar 2018 18:06:56 +0100
Subject: [PATCH v5 19/36] drm/rockchip: Restore psr->state when
 enable/disable psr failed
In-Reply-To: <20180309222327.18689-20-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-20-enric.balletbo@collabora.com>
Message-ID: <8139042.U9NTKlgutZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. M?rz 2018, 23:23:10 CET schrieb Enric Balletbo i Serra:
> From: zain wang <wzz@rock-chips.com>
> 
> If we failed disable psr, it would hang the display until next psr
> cycle coming. So we should restore psr->state when it failed.
> 
> Cc: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
