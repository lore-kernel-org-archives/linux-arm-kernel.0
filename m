From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  5 Apr 2017 10:01:29 -0500
Subject: [GIT PULL 2/2] SoCFPGA defconfig update for v4.12
In-Reply-To: <1491404489-10411-1-git-send-email-dinguyen@kernel.org>
References: <1491404489-10411-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1491404489-10411-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in this defconfig update for v4.12.

Thanks,
Dinh


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_defconfig_updates_for_v4.12

for you to fetch changes up to b685b264636b4f3f3eaa0b62fee674a45f2b1679:

  ARM: socfpga: updates for socfpga_defconfig (2017-03-16 08:05:46 -0500)

----------------------------------------------------------------
SoCFPGA defconfig updates for v4.12
- enables TSE(Triple-Speed-Ethernet) support

----------------------------------------------------------------
Jia Jie Ho (1):
      ARM: socfpga: updates for socfpga_defconfig

 arch/arm/configs/socfpga_defconfig | 1 +
 1 file changed, 1 insertion(+)
