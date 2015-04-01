From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 02 Apr 2015 03:16:22 +0900
Subject: [GIT PULL 2/5] Samsung defconfig udpates for v4.1
Message-ID: <551C35F6.1090602@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig

for you to fetch changes up to bb84296ae52da844c9cab81e0197152a69f2f841:

  ARM: exynos_defconfig: Enable HDMI support (2015-03-27 02:00:09 +0900)

----------------------------------------------------------------
Samsung defconfig updates for v4.1

- update exynos-defconfig
  : enable HDMI, CPUidle, ChromeOS EC chardev driver
    and thermal emulation, Marvell WiFi-Ex, CPUfreq,
    and support for NFS rootfs
  : remove EXYNOS_THERMAL_CORE define
    and disable IOMMU support until support it

----------------------------------------------------------------
Javier Martinez Canillas (5):
      ARM: exynos_defconfig: Disable IOMMU support
      ARM: exynos_defconfig: Enable Marvell WiFi-Ex support
      ARM: exynos_defconfig: Enable ChromeOS EC chardev driver
      ARM: exynos_defconfig: Enable options to mount a rootfs via NFS
      ARM: exynos_defconfig: Enable HDMI support

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable CPU idle

Lukasz Majewski (3):
      ARM: exynos_defconfig: Remove CONFIG_EXYNOS_THERMAL_CORE define
      ARM: exynos_defconfig: Enable thermal emulation for Exynos TMU
      ARM: exynos_defconfig: Enable support for cpufreq on Exynos SoCs

 arch/arm/configs/exynos_defconfig | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
