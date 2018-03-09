From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 9 Mar 2018 15:31:55 +0000
Subject: [PATCH] arm64: defconfig: enable IOSCHED_DEADLINE
In-Reply-To: <1517318577-56430-1-git-send-email-john.garry@huawei.com>
References: <1517318577-56430-1-git-send-email-john.garry@huawei.com>
Message-ID: <5AA2A8EB.6050405@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 2018/1/30 13:22, John Garry wrote:
> For certain workloads the deadline IO scheduler offers
> particular advantages over other schedulers and has shown
> to perform better, so enable it.
> 
> The default IO scheduler is unaffected by this change, and
> currently is CFQ.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied into hisilicon defconfig tree.
Thanks!

BR,
Wei

> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 634b373..40c72e6 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -31,7 +31,6 @@ CONFIG_PROFILING=y
>  CONFIG_JUMP_LABEL=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> -# CONFIG_IOSCHED_DEADLINE is not set
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_ALPINE=y
>  CONFIG_ARCH_BCM2835=y
> 
