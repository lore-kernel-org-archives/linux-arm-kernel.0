From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 23 Nov 2016 09:59:14 +0100
Subject: [GIT PULL] STi defconfig fix for v4.9-rcs
Message-ID: <0492803d-d136-618d-bf06-51f0001d039b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Please consider this set for inclusion into the v4.9-rc.

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-defconfig-for-4.9-rc

for you to fetch changes up to bb8d1edc272b972758dc75e861c9c17cddcd1d21:

  ARM: multi_v7_defconfig: enable STMicroelectronics HVA driver (2016-11-23 09:25:23 +0100)

----------------------------------------------------------------
STi defconfig fix:

Enable HVA (Hardware Video Accelerator) video encoder
driver for STMicroelectronics SoC.

----------------------------------------------------------------
Patrice Chotard (1):
      ARM: multi_v7_defconfig: enable STMicroelectronics HVA driver

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)
