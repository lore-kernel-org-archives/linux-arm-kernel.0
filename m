From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 Mar 2018 18:00:34 +0100
Subject: [PATCH v5 01/36] drm/bridge: analogix_dp: detect Sink PSR state
 after configuring the PSR
In-Reply-To: <20180309222327.18689-2-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-2-enric.balletbo@collabora.com>
Message-ID: <1575553.xWh7et7hg4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. M?rz 2018, 23:22:52 CET schrieb Enric Balletbo i Serra:
> From: Yakir Yang <ykk@rock-chips.com>
> 
> Make sure the request PSR state takes effect in analogix_dp_send_psr_spd()
> function, or print the sink PSR error state if we failed to apply the
> requested PSR setting.
> 
> Cc: ?? ? <wzz@rock-chips.com>
> Cc: St?phane Marchesin <marcheu@chromium.org>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> [seanpaul changed timeout loop to a readx poll]
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
