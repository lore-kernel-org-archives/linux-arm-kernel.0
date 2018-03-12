From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 Mar 2018 17:29:20 +0100
Subject: [PATCH v5 04/36] drm/rockchip: add mutex vop lock
In-Reply-To: <20180309222327.18689-5-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-5-enric.balletbo@collabora.com>
Message-ID: <3618546.KCVSigYX7Y@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. M?rz 2018, 23:22:55 CET schrieb Enric Balletbo i Serra:
> From: zain wang <wzz@rock-chips.com>
> 
> Add a lock to vop to avoid disabling the crtc while waiting for a line
> flag while enabling psr. If we disable in the middle of waiting for the
> line flag, we'll end up timing out or worse.
> 
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
