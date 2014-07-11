From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 11 Jul 2014 16:07:21 +0900
Subject: [PATCH 2/2] PCI: tegra: Fix license string
In-Reply-To: <1405061938-2191-2-git-send-email-thierry.reding@gmail.com>
References: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
 <1405061938-2191-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <004301cf9cd6$c22ae840$4680b8c0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 11, 2014 3:59 PM, Thierry Reding wrote:
> 
> From: Thierry Reding <treding@nvidia.com>
> 
> The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not
> "GPLv2".
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 7df5aaf58921..14ec5b2c69e0 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -1742,4 +1742,4 @@ module_platform_driver(tegra_pcie_driver);
> 
>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
>  MODULE_DESCRIPTION("NVIDIA Tegra PCIe driver");
> -MODULE_LICENSE("GPLv2");
> +MODULE_LICENSE("GPL v2");
> --
> 2.0.1
