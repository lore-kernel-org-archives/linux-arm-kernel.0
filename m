From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Fri, 16 Oct 2015 09:28:44 -0500
Subject: [GIT PULL] SoCFPGA defconfig for v4.4
In-Reply-To: <1445005724-32349-1-git-send-email-dinh.linux@gmail.com>
References: <1445005724-32349-1-git-send-email-dinh.linux@gmail.com>
Message-ID: <1445005724-32349-3-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please consider pulling this defconfig update for v4.4.

Thanks,
Dinh

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_defconfig_for_v4.4

for you to fetch changes up to b97cecc7a61df121f2c1e350e09fc784a1706ef0:

  ARM: socfpga_defconfig: enable fpga manager (2015-10-13 14:25:18 -0500)

----------------------------------------------------------------
SoCFPGA defconfig update for v4.4
- Add the FPGA manager config option

----------------------------------------------------------------
Alan Tull (1):
      ARM: socfpga_defconfig: enable fpga manager

 arch/arm/configs/socfpga_defconfig | 2 ++
 1 file changed, 2 insertions(+)
