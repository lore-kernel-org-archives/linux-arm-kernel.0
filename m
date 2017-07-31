From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 31 Jul 2017 10:52:56 -0700
Subject: [GIT PULL] Amlogic fixes for v4.13-rc
Message-ID: <7hefswqyrr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes

for you to fetch changes up to 72fb2c852188ad75ab3badb55bf491925b9eba46:

  ARM64: dts: meson-gxl-s905x-libretech-cc: fixup board definition (2017-07-20 17:50:22 -0700)

----------------------------------------------------------------
Amlogic fixes for v4.13-rc
- 2 minor DT fixes

----------------------------------------------------------------
Jerome Brunet (2):
      ARM64: dts: meson-gx: use specific compatible for the AO pwms
      ARM64: dts: meson-gxl-s905x-libretech-cc: fixup board definition

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   |   4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 94 insertions(+), 15 deletions(-)
