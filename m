From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 20 Jan 2017 16:56:33 +0000
Subject: [PATCH RESEND] arm64: defconfig: Enable NUMA and NUMA_BALANCING
In-Reply-To: <1484719039-34801-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1484719039-34801-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <58824141.3010403@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On 2017/1/18 5:57, Kefeng Wang wrote:
> Since much more arm64 SoCs with numa nodes, it's better to enable
> NUMA and NUMA_BALANCING to improve the performance on test.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Applied to the hisilicon soc tree.
Thanks!

Best Regards,
Wei

>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 33b744d..0ebb228 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -11,6 +11,7 @@ CONFIG_TASK_XACCT=y
>  CONFIG_TASK_IO_ACCOUNTING=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
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
