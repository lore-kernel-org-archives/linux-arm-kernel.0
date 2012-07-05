From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jul 2012 16:15:24 +0800
Subject: [GIT PULL] mxs fixes for 3.5 (part 2)
Message-ID: <20120705081522.GI2595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is a fix I just received from Lauri, which is to fix an apx4devkit
board regression introduced by common clk migration.  Please consider
to pull it for 3.5.

Regards,
Shawn

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/fixes-for-3.5

Lauri Hintsala (1):
      ARM: apx4devkit: fix FEC enabling PHY clock

 arch/arm/mach-mxs/mach-apx4devkit.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
