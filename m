From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 08 Mar 2018 17:38:30 +0100
Subject: [PATCH v9 2/5] drm/rockchip: inno_hdmi: Fix error handling path.
In-Reply-To: <20180302175757.28192-3-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
 <20180302175757.28192-3-enric.balletbo@collabora.com>
Message-ID: <3005091.N6bvNJytYr@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 2. M?rz 2018, 18:57:54 CET schrieb Enric Balletbo i Serra:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Add missing error handling in bind().
> 
> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> [moved clk_disable_unprepare reordering in unbind to separate patch]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to drm-misc-next

Thanks
Heiko
