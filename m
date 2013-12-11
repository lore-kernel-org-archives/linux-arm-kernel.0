From: horms@verge.net.au (Simon Horman)
Date: Thu, 12 Dec 2013 08:51:35 +0900
Subject: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI
 host maintainers
In-Reply-To: <20131211183237.GI4699@google.com>
References: <20131211183237.GI4699@google.com>
Message-ID: <20131211235135.GA11671@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 11:32:37AM -0700, Bjorn Helgaas wrote:
> If this looks reasonable, I'll merge it via the PCI tree for v3.13.
> 
> Bjorn
> 
> 
> MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI host maintainers
> 
> Add entries for PCI host controller drivers in drivers/pci/host/.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Renesas R-Car potion:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  MAINTAINERS |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8285ed4676b6..826c722d92ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6449,16 +6449,47 @@ F:	drivers/pci/
>  F:	include/linux/pci*
>  F:	arch/x86/pci/
>  
> +PCI DRIVER FOR DESIGNWARE
> +M:	Jingoo Han <jg1.han@samsung.com>
> +L:	linux-pci at vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/host/*designware*
> +
> +PCI DRIVER FOR IMX6
> +M:	Shawn Guo <shawn.guo@linaro.org>
> +L:	linux-pci at vger.kernel.org
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/pci/host/*imx6*
> +
> +PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
> +M:	Jason Cooper <jason@lakedaemon.net>
> +L:	linux-pci at vger.kernel.org
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/pci/host/*mvebu*
> +
>  PCI DRIVER FOR NVIDIA TEGRA
>  M:	Thierry Reding <thierry.reding@gmail.com>
>  L:	linux-tegra at vger.kernel.org
> +L:	linux-pci at vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>  F:	drivers/pci/host/pci-tegra.c
>  
> +PCI DRIVER FOR RENESAS R-CAR
> +M:	Simon Horman <horms@verge.net.au>
> +M:	Magnus Damm <magnus.damm@gmail.com>
> +L:	linux-pci at vger.kernel.org
> +L:	linux-sh at vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/host/*rcar*
> +
>  PCI DRIVER FOR SAMSUNG EXYNOS
>  M:	Jingoo Han <jg1.han@samsung.com>
>  L:	linux-pci at vger.kernel.org
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	drivers/pci/host/pci-exynos.c
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
