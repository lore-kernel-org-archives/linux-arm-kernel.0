From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 20 Mar 2017 16:59:56 +0100
Subject: [PATCH v6] drm/rockchip: Refactor the component match logic.
In-Reply-To: <1489981360-31846-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1489981360-31846-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <4007803.XWGhEIeQWc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 20. M?rz 2017, 11:42:40 CET schrieb Jeffy Chen:
> Currently we are adding all components from the dts, if one of their
> drivers been disabled, we would not be able to bring up others.
> 
> Refactor component match logic, follow exynos drm.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Acked-by: Mark Yao <mark.yao@rock-chips.com>

On rk3036 and rk3288
Tested-by: Heiko Stuebner <heiko@sntech.de>
