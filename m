From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Mar 2013 14:03:19 +0800
Subject: [GIT PULL] mxs fixes for 3.9, take 3
Message-ID: <20130319060318.GL12462@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-fixes-3.9-3

for you to fetch changes up to 6a15075eced2d780fa6c5d83682410f47f2e800b:

  ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0 (2013-03-19 11:07:58 +0800)

----------------------------------------------------------------
The mxs fixes for 3.9, take 3:
 - Fix the shifted framebuffer with X11 system

----------------------------------------------------------------
Marek Vasut (1):
      ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0

 arch/arm/mach-mxs/mach-mxs.c |   24 ++++++++++++------------
 drivers/video/mxsfb.c        |    7 +++++--
 include/linux/mxsfb.h        |    7 +++++--
 3 files changed, 22 insertions(+), 16 deletions(-)
