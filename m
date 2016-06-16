From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Jun 2016 17:11:22 +0200
Subject: [PATCH] arm64: configs: enable PCIe driver for Armada 7K/8K
In-Reply-To: <1463659894-20585-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Thu, 19 May 2016 14:11:34 +0200")
References: <1463659894-20585-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87eg7x9nj9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., mai 19 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This patch enables the driver for the PCIe host controller found on
> the Marvell Armada 7K/8K ARM64 SoCs.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/defconfig

Thanks,

Gregory

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0bd559a..23821c2 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -63,6 +63,7 @@ CONFIG_PCI_XGENE=y
>  CONFIG_PCI_LAYERSCAPE=y
>  CONFIG_PCI_HISI=y
>  CONFIG_PCIE_QCOM=y
> +CONFIG_PCIE_ARMADA_8K=y
>  CONFIG_ARM64_VA_BITS_48=y
>  CONFIG_SCHED_MC=y
>  CONFIG_PREEMPT=y
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
