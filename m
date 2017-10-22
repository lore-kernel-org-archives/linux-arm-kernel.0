From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 22 Oct 2017 03:31:43 -0700
Subject: [GIT PULL] Amlogic defconfig updatest for v4.15
Message-ID: <7hwp3nqxrk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-defconfig

for you to fetch changes up to fce107aea2cbea0d3bc6d170ba6ce14111661a1b:

  ARM: multi_v7_defconfig: enable the Meson MX SDIO/MMC controller (2017-10-11 17:19:18 -0700)

----------------------------------------------------------------
Amlogic: defconfig updates for v4.15
- enable SDIO/MMC controller

----------------------------------------------------------------
Martin Blumenstingl (1):
      ARM: multi_v7_defconfig: enable the Meson MX SDIO/MMC controller

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)
