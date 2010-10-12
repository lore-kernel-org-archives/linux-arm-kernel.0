From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Oct 2010 14:08:39 -0700
Subject: [GIT PULL] one omap fix for 2.6.36
Message-ID: <20101012210839.GB25462@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull a one-liner from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit cb655d0f3d57c23db51b981648e452988c0223f9:

  Linux 2.6.36-rc7 (2010-10-06 13:39:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Hari Kanigeri (1):
      omap: iommu-load cam register before flushing the entry

 arch/arm/plat-omap/iommu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
