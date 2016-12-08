From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 8 Dec 2016 13:38:55 +0800
Subject: [PATCH] arm64: defconfig: Enable NUMA and NUMA_BALANCING
In-Reply-To: <1480499575-43628-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1480499575-43628-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <b9838176-487a-117a-01b0-d5c4a4b3646f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Arnd

On 2016/11/30 17:52, Kefeng Wang wrote:
> Enable NUMA and NUMA_BALANCING to improve the performance on board
> with multiple numa nodes.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index dab2cb0..967f6e5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -12,6 +12,7 @@ CONFIG_TASK_IO_ACCOUNTING=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=14
> +CONFIG_NUMA_BALANCING=y
>  CONFIG_MEMCG=y
>  CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y
> @@ -72,6 +73,7 @@ CONFIG_PCIE_QCOM=y
>  CONFIG_PCIE_ARMADA_8K=y
>  CONFIG_ARM64_VA_BITS_48=y
>  CONFIG_SCHED_MC=y
> +CONFIG_NUMA=y
>  CONFIG_PREEMPT=y
>  CONFIG_KSM=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y
> 
