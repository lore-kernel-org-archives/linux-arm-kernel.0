From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 14 Mar 2018 11:32:56 +0100
Subject: [PATCH v5 03/36] drm/bridge: analogix_dp: Don't change psr while
 bridge is disabled
In-Reply-To: <20180309222327.18689-4-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-4-enric.balletbo@collabora.com>
Message-ID: <2007370.FhFqbYQVrQ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. M?rz 2018, 23:22:54 CET schrieb Enric Balletbo i Serra:
> From: zain wang <wzz@rock-chips.com>
> 
> There is a race between AUX CH bring-up and enabling bridge which will
> cause link training to fail. To avoid hitting it, don't change psr state
> while enabling the bridge.
> 
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> [seanpaul fixed up the commit message a bit and renamed *_supported to
> *_enabled] Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


applied to drm-misc-next

Thanks
Heiko
