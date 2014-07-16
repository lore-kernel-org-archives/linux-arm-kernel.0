From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 Jul 2014 09:08:24 +0900
Subject: [PATCH 2/2] PCI: rcar: Fix GPL v2 license string typo
In-Reply-To: <20140715225652.22578.86359.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140715225652.22578.86359.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20140716000824.GA25244@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 04:56:52PM -0600, Bjorn Helgaas wrote:
> The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not "GPLv2".
> 
> Based-on-work-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pci/host/pcie-rcar.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index f7d3de32c9a0..a393cc60b5a3 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1003,4 +1003,4 @@ module_platform_driver(rcar_pcie_driver);
>  
>  MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
>  MODULE_DESCRIPTION("Renesas R-Car PCIe driver");
> -MODULE_LICENSE("GPLv2");
> +MODULE_LICENSE("GPL v2");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
