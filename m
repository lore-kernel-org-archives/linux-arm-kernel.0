From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 20 Oct 2017 09:49:23 +0800
Subject: [PATCH v6 05/10] drm/rockchip: analogix_dp: Add a sanity check
 for rockchip_drm_psr_register()
In-Reply-To: <20171019034812.13768-6-jeffy.chen@rock-chips.com>
References: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
 <20171019034812.13768-6-jeffy.chen@rock-chips.com>
Message-ID: <1c7f4eaf-6fa2-58e1-a216-46ac039fffd5@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?10?19? 11:48, Jeffy Chen wrote:
> The rockchip_drm_psr_register() can fail, so add a sanity check for that.
>
> Also reorder the calls in unbind() to match bind().
>
> Signed-off-by: Jeffy Chen<jeffy.chen@rock-chips.com>

Looks good for me
Acked-by: Mark Yao <mark.yao@rock-chips.com>

Mark
