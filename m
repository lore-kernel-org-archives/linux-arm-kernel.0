From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 4 Dec 2014 17:36:39 +0100
Subject: [GIT PULL v3 1/4] ARM: tegra: IOMMU support for v3.19
In-Reply-To: <2182969.Fashf5lCE4@wuerfel>
References: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
 <1417707950-7633-1-git-send-email-thierry.reding@gmail.com>
 <2182969.Fashf5lCE4@wuerfel>
Message-ID: <20141204163637.GA16914@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 05:21:27PM +0100, Arnd Bergmann wrote:
> On Thursday 04 December 2014 16:45:49 Thierry Reding wrote:
> > Hi ARM SoC maintainers,
> > 
> > The following changes since commit 0690cbd2e55a72a8eae557c389d1a136ed9fa142:
> > 
> >   powerpc/iommu: Rename iommu_[un]map_sg functions (2014-11-18 11:30:01 +0100)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.19-iommu
> > 
> > for you to fetch changes up to 8918465163171322c77a19d5258a95f56d89d2e4:
> > 
> >   memory: Add NVIDIA Tegra memory controller support (2014-12-04 16:11:47 +0100)
> > 
> > Here's a version of the pull request rebased on top of Joerg's core
> > branch from the IOMMU tree. It has the advantage of having resolved
> > the merge conflicts and the disadvantage of pulling in v3.18-rc3.
> > It also contains an updated commit description with some details
> > that ensued from a discussion regarding the DT binding as well as
> > the memory-client to SWGROUP mapping tables.
> > 
> > This pull request also contains fixes for a build error reported by the
> > 0-day builder as well as a couple of issues in the IOMMU domain detach
> > path that I've found since v2 while doing extensive driver unload and
> > reload stress testing.
> 
> Pulled into next/drivers, thanks for you patience!

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/8e8e2763/attachment.sig>
