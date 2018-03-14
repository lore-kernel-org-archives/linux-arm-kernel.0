From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 14 Mar 2018 11:32:42 +0100
Subject: [PATCH v5 02/36] drm/rockchip: Remove analogix psr worker
In-Reply-To: <20180309222327.18689-3-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-3-enric.balletbo@collabora.com>
Message-ID: <3214934.ZBQRvzMx2H@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. M?rz 2018, 23:22:53 CET schrieb Enric Balletbo i Serra:
> From: Sean Paul <seanpaul@chromium.org>
> 
> Now that the spinlocks and timers are gone, we can remove the psr
> worker located in rockchip's analogix driver and do the enable/disable
> directly. This should simplify the code and remove races on disable.
> 
> Cc: ?? ? <wzz@rock-chips.com>
> Cc: St?phane Marchesin <marcheu@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


applied to drm-misc-next

Thanks
Heiko
