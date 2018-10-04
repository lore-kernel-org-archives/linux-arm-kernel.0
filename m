From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 04 Oct 2018 15:08:20 +0200
Subject: [GIT PULL] arm64: dts: Amlogic updtes for v4.20, round 3
Message-ID: <7hsh1loo57.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Arnd,

One more small round of DT updates/cleanups for Amlogic SoCs.

Please pull,

Thanks

Kevin


The following changes since commit 9c8c52f7cb4f3b604bb9836947dadfbb255f465f:

  arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support (2018-09-26 02:04:58 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-3

for you to fetch changes up to 59d925ac203b4a3d6fae3e0dda183261fb81bf7a:

  arm64: dts: meson-axg: s400: disable emmc (2018-10-03 08:52:04 -0700)

----------------------------------------------------------------
arm64: dts: Amlogic updates for v4.20, round 3
- AXG: fix eMMC

----------------------------------------------------------------
Jerome Brunet (2):
      arm64: dts: meson-axg: s400: add missing emmc pwrseq
      arm64: dts: meson-axg: s400: disable emmc

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
