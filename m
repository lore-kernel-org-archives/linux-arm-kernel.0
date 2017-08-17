From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 16 Aug 2017 21:14:34 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.14
Message-ID: <7hmv6yal05.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to f72d6f6037b7b07927f78e159e4949b8e0263258:

  ARM64: dts: meson-gx: use stable UART bindings with correct gate clock (2017-08-08 14:48:56 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.14
- add GPIO line names to a few boards
- MMC regulator settle time updates
- misc cleanups/fixups

----------------------------------------------------------------
Helmut Klein (1):
      ARM64: dts: meson-gx: use stable UART bindings with correct gate clock

Jerome Brunet (1):
      ARM64: dts: meson-gxbb: p20x: add card regulator settle times

Kevin Hilman (1):
      dt-bindings: amlogic: add unstable statement

Martin Blumenstingl (1):
      ARM64: dts: meson-gx: consistently use the GIC_SPI and IRQ type macros

Neil Armstrong (3):
      ARM64: dts: meson-gx: Add SoC info register
      ARM64: dts: meson-gxl-khadas-vim: Add GPIO lines names
      ARM64: dts: meson-gxbb-nanopi-k2: Add GPIO lines names

 Documentation/devicetree/bindings/arm/amlogic.txt          | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                  | 26 +++++++++++++++-----------
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts       | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi           |  3 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                | 25 +++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                 | 25 +++++++++++++++++++++++++
 7 files changed, 194 insertions(+), 11 deletions(-)
