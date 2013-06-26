From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 13:06:27 +0200
Subject: [PATCH 18/23] iommu/tegra: smmu: Workaround PCIe IOMMU'able
In-Reply-To: <1372238906-9346-19-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-19-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626110626.GO27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:21PM +0300, Hiroshi Doyu wrote:
> Make PCIe work as it is. IOMMU support can be implemented later.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  drivers/iommu/tegra-smmu.c | 3 +++
>  1 file changed, 3 insertions(+)

Can you provide more information about what the problem is here? Why is
PCIe not working when mapped through the IOMMU?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/308f25c8/attachment-0001.sig>
