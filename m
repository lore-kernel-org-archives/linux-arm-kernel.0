From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 08 Mar 2018 17:38:20 +0100
Subject: [PATCH v9 1/5] drm/rockchip: dw-mipi-dsi: Fix connector and
 encoder cleanup.
In-Reply-To: <20180302175757.28192-2-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
 <20180302175757.28192-2-enric.balletbo@collabora.com>
Message-ID: <6137181.UL6MkM7i5q@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 2. M?rz 2018, 18:57:53 CET schrieb Enric Balletbo i Serra:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> In bind()'s error handling path call destroy functions instead of
> cleanup functions for encoder and connector and reorder to match how is
> called in bind().
> 
> In unbind() call the connector and encoder destroy functions.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to drm-misc-next

Thanks
Heiko
