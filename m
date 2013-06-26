From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 13:15:37 +0200
Subject: [PATCH 18/23] iommu/tegra: smmu: Workaround PCIe IOMMU'able
In-Reply-To: <20130626.140906.1216615781918366349.hdoyu@nvidia.com>
References: <1372238906-9346-19-git-send-email-hdoyu@nvidia.com>
 <20130626110626.GO27083@manwe>
 <20130626.140906.1216615781918366349.hdoyu@nvidia.com>
Message-ID: <20130626111537.GR27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 01:09:06PM +0200, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding@gmail.com> wrote @ Wed, 26 Jun 2013 13:06:27 +0200:
> 
> > * PGP Signed by an unknown key
> > 
> > On Wed, Jun 26, 2013 at 12:28:21PM +0300, Hiroshi Doyu wrote:
> > > Make PCIe work as it is. IOMMU support can be implemented later.
> > > 
> > > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > > ---
> > >  drivers/iommu/tegra-smmu.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> > Can you provide more information about what the problem is here? Why is
> > PCIe not working when mapped through the IOMMU?
> 
> I haven't had a code to register PCI device as IOMMU'able as
> ops->add_device() does for platform_devices. I'll add this comment.

Okay, that should be solved then when we merge the PCIe driver. I hope
that can happen soon.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/f5318ac3/attachment-0001.sig>
