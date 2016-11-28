From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 28 Nov 2016 13:37:00 +0100
Subject: [GIT PULL] STi defconfig updates for v4.10 round 3
Message-ID: <2956a25a-ef39-842a-d0cd-baf4a01f7a2c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this third round of multi_v7_defconfig updates for v4.10 :

The following changes since commit 57dae748959d0abae2b382ccee68621a82f827c8:

  ARM: multi_v7_defconfig: Remove ST_THERMAL_SYSCFG Kconfig symbol (2016-10-21 17:05:54 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-defconfig-for-4.10-round3

for you to fetch changes up to 88d7658bf31f17296b8792e62268825d066d23c4:

  ARM: multi_v7_defconfig: enable STMicroelectronics HVA driver (2016-11-28 13:02:14 +0100)

----------------------------------------------------------------

STi defconfig fix:

Enable HVA (Hardware Video Accelerator) video encoder
driver for STMicroelectronics SoC.

----------------------------------------------------------------
Patrice Chotard (1):
      ARM: multi_v7_defconfig: enable STMicroelectronics HVA driver

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)
