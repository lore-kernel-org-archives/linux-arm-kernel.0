From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 12:56:42 +0200
Subject: [PATCH 11/23] iommu/tegra: smmu: Add of_mach_id for T114
In-Reply-To: <1372238906-9346-12-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-12-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626105641.GM27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:14PM +0300, Hiroshi Doyu wrote:
> Add of_mach_id for T114

I don't think of_mach_id is the right word. Why not use a subject such
as "iommu/tegra: smmu: Add Tegra114 support". And instead of duplicating
the subject in the commit message, perhaps you can say instead that for
Tegra114 the SMMU is the same as for Tegra30 (which I assume here given
that no code changes are required).

And we really need the nvidia,tegra114-smmu.txt binding documentation.
Either that or update the nvidia,tegra30-smmu.txt with Tegra114 specific
information.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/a02918a0/attachment-0001.sig>
