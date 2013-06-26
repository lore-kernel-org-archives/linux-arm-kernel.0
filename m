From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 13:05:10 +0200
Subject: [PATCH 17/23] iommu/tegra: smmu: Use swgroups instead of pdata
In-Reply-To: <1372238906-9346-18-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-18-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626110509.GN27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:20PM +0300, Hiroshi Doyu wrote:
> Instead of using platfrom data, DT passes "nvidia,swgroups".
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  drivers/iommu/tegra-smmu.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)

Could this patch not be squashed into the previous one? Moving from
using the swgroups from DT and replacing platform data seems to be the
same logical change.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/4f82beb3/attachment-0001.sig>
