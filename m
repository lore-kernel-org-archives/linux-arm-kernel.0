From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 21 Sep 2018 15:03:14 +0100
Subject: [PATCH] arm64: defconfig: Enable PCIEPORTBUS
In-Reply-To: <1535632172-127690-1-git-send-email-liudongdong3@huawei.com>
References: <1535632172-127690-1-git-send-email-liudongdong3@huawei.com>
Message-ID: <5BA4FA22.7000602@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongdong,

On 2018/8/30 13:29, Dongdong Liu wrote:
> PCIe features like AER, Hotplug, PME, DPC depend on PCIEPORTBUS,
> so enable PCIEPORTBUS as default.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Thanks!
Applied to the hisilicon defconfig tree.

Best Regards,
Wei

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f67e8d5..e5652e9 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -67,6 +67,7 @@ CONFIG_ARCH_XGENE=y
>  CONFIG_ARCH_ZX=y
>  CONFIG_ARCH_ZYNQMP=y
>  CONFIG_PCI=y
> +CONFIG_PCIEPORTBUS=y
>  CONFIG_PCI_IOV=y
>  CONFIG_HOTPLUG_PCI=y
>  CONFIG_HOTPLUG_PCI_ACPI=y
> 
