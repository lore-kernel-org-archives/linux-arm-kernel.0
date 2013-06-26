From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 13:07:47 +0200
Subject: [PATCH 19/23] iommu/tegra: smmu: Unfied driver for Tegra SoCs
In-Reply-To: <1372238906-9346-20-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-20-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626110747.GP27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:22PM +0300, Hiroshi Doyu wrote:
> Support multiple generation of Tegra SoCs with this unified
> SMMU driver. Necessary info is expected to be passed from DT.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  drivers/iommu/tegra-smmu.c | 80 ++--------------------------------------------
>  1 file changed, 3 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 6e82df3..ae71721 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -1,5 +1,5 @@
>  /*
> - * IOMMU API for SMMU in Tegra30
> + * IOMMU API for SMMU in Tegra SoC

Maybe "Tegra30 and later SoCs" given that Tegra20 has no compatible
IOMMU?

> -MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra30");
> +MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra SoC");

Same here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/7a189b9e/attachment.sig>
