From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 20 May 2014 08:01:34 +0200
Subject: [GIT PULL 2/2] ARM: berlin: SoC changes for v3.16
In-Reply-To: <1400565694-1568-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1400565694-1568-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1400565694-1568-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

these are the SoC related changes for Berlin SoCs. Alexandre Belloni and
Antoine Tenart picked up work on quad-core Cortex A9 BG2Q SoC and provided
valuable drivers for pinctrl and clocks. The corresponding drivers should
go to the submaintainer's trees, this is what is left to do on the
mach-berlin side.

Please pull.

Thanks,
  Sebastian

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  https://github.com/shesselba/linux-berlin.git tags/berlin-soc-3.16

for you to fetch changes up to 03dac26a831c51e544dc95ba12ea9e3520829e7e:

  ARM: berlin: add the pinctrl dependency for the Marvell Berlin SoCs (2014-05-19 22:52:39 +0200)

----------------------------------------------------------------
Despite relatively young Berlin SoC support, we already have support
for a BG2Q SoC provided by Alexandre Belloni and Antoine Tenart. Also,
we gained support for DW gpio and a pinctrl driver.

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: berlin: add MACH_BERLIN_BG2Q symbol

Antoine Tenart (3):
      ARM: berlin: add Marvell Armada 1500 pro to Marvell doc
      ARM: berlin: add the LIBGPIO as a dependency for the BG2Q
      ARM: berlin: add the pinctrl dependency for the Marvell Berlin SoCs

 Documentation/arm/Marvell/README |  5 +++++
 arch/arm/mach-berlin/Kconfig     | 10 ++++++++++
 2 files changed, 15 insertions(+)
