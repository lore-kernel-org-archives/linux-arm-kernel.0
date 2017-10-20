From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 20 Oct 2017 09:50:01 +0800
Subject: [PATCH v6 06/10] drm/rockchip: dw-mipi-dsi: Fix error handling
 path
In-Reply-To: <20171019034812.13768-7-jeffy.chen@rock-chips.com>
References: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
 <20171019034812.13768-7-jeffy.chen@rock-chips.com>
Message-ID: <fc82d57d-5c41-0615-b391-39b20bc41024@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?10?19? 11:48, Jeffy Chen wrote:
> Add missing pm_runtime_disable() in bind()'s error handling path.
>
> Also cleanup encoder & connector in unbind().
>
> Fixes: 80a9a059d4e4 ("drm/rockchip/dsi: add dw-mipi power domain support")
> Signed-off-by: Jeffy Chen<jeffy.chen@rock-chips.com>

Looks good for me
Acked-by: Mark Yao <mark.yao@rock-chips.com>

Mark
