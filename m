From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 14 Mar 2018 11:39:11 +0100
Subject: [PATCH v5 05/36] drm/bridge: analogix_dp: add fast link train for
 eDP
In-Reply-To: <20180309222327.18689-6-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-6-enric.balletbo@collabora.com>
Message-ID: <6139185.TexXAUNAzh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. M?rz 2018, 23:22:56 CET schrieb Enric Balletbo i Serra:
> From: zain wang <wzz@rock-chips.com>
> 
> We would meet a short black screen when exit PSR with the full link
> training, In this case, we should use fast link train instead of full
> link training.
> 
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

applied to drm-misc-next

Checking the whole series, there is nothing else that touches the
reordered headers, so I've dropped that change, leaving only the
newly added iopoll.h inclusion in [0].

Thanks
Heiko


[0] https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f9d5680596f2dac390918e6aec3e174db03633a3
