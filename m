From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:29:16 +0900
Subject: [GIT PULL 0/2] Second Round of Renesas ARM based SoC updates for v3.12
Message-ID: <cover.1375838109.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

Please consider this second Round of renesas ARM based SoC updates for v3.12.

This pull-request is based on a merge of renesas-soc-for-v3.12 and
renesas-fixes-for-v3.12, both of which I have previously sent pull-requests
for.


The following changes since commit 21c7a134051f2f753d359a02923223ad9181da31:

  Merge tag 'renesas-fixes-for-v3.12' into soc2-base (2013-08-06 17:56:43 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.12

for you to fetch changes up to d687f4d1993fa046171dbb1ca1970a3172ce11b9:

  ARM: shmobile: r8a7740: Add TPU clock entry for DT platforms (2013-08-06 17:57:09 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC updates for v3.12

* Increased clock coverage for r8a7740 and r8a7790 SoCs

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: r8a7740: Add TPU clock entry for DT platforms

Simon Horman (1):
      ARM: shmobile: r8a7790: clocks for Ether support

 arch/arm/mach-shmobile/clock-r8a7740.c | 1 +
 arch/arm/mach-shmobile/clock-r8a7790.c | 4 ++++
 2 files changed, 5 insertions(+)
