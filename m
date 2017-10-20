From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 20 Oct 2017 09:51:16 +0800
Subject: [PATCH v6 10/10] drm/rockchip: dw_hdmi: Fix error handling path
In-Reply-To: <20171019034812.13768-11-jeffy.chen@rock-chips.com>
References: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
 <20171019034812.13768-11-jeffy.chen@rock-chips.com>
Message-ID: <bd662144-78c8-b448-6dd0-36d68bacca44@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?10?19? 11:48, Jeffy Chen wrote:
> Add missing clk_disable_unprepare() in bind()'s error handling path and
> unbind().
>
> Also inline clk_prepare_enable() with bind().
>
> Fixes: 12b9f204e804 ("drm: bridge/dw_hdmi: add rockchip rk3288 support")
> Signed-off-by: Jeffy Chen<jeffy.chen@rock-chips.com>

Looks good for me
Acked-by: Mark Yao <mark.yao@rock-chips.com>

Mark
