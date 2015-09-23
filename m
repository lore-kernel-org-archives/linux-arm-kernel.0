From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 23 Sep 2015 09:19:04 +0200
Subject: [PATCH] ARM: dts: exynos5420: fix wrong clock binding for
 sysmmu_fimd1_1
In-Reply-To: <1442990906-16411-1-git-send-email-jy0922.shim@samsung.com>
References: <1442990906-16411-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <56025268.6040405@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joonyoung,

On 09/23/2015 08:48 AM, Joonyoung Shim wrote:
> The sysmmu_fimd1_1 should bind the clock CLK_SMMU_FIMD1M1, not the clock
> CLK_SMMU_FIMD1M0. CLK_SMMU_FIMD1M0 is a clock for the sysmmu_fimd1_0.
> 

Can you please mention in the commit message if this patch is solving an
issue on a given machine or if it is just for the sake of correctness.

Git blame shows that this was added by commit b70045167815 ("ARM: dts: add
sysmmu nodes for exynos5420") so please add a Fixes: tag.

> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: <stable@vger.kernel.org> # v4.2
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
