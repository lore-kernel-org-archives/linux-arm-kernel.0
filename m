From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 08 Mar 2018 17:38:54 +0100
Subject: [PATCH v9 4/5] drm/rockchip: dw_hdmi: Move HDMI vpll clock enable
 to bind()
In-Reply-To: <20180302175757.28192-5-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
 <20180302175757.28192-5-enric.balletbo@collabora.com>
Message-ID: <4713538.mFGgDtM9HE@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 2. M?rz 2018, 18:57:56 CET schrieb Enric Balletbo i Serra:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> The HDMI vpll clock should be enabled when bind() is called. So move the
> clk_prepare_enable of that clock to bind() function and add the missing
> clk_disable_unprepare() required in error handling path and unbind().
> 
> Fixes: 12b9f204e804 ("drm: bridge/dw_hdmi: add rockchip rk3288 support")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to drm-misc-next

Thanks
Heiko
