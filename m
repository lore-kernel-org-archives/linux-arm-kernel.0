From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 29 Aug 2018 08:50:03 -0700
Subject: [GIT PULL] Amlogic fixes for v4.19-rc
Message-ID: <7hk1o9895g.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Arnd,

A round of DT fixes for Amlogic SoCs for v4.19-rc.

The are all platform-specific DT, 2 are simple fixes, and the 3
meson-axg patches are to enable audio devices that were fully enabled by
reset changes in the late PR recently sent and merged.

Kevin

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes

for you to fetch changes up to 1caa378e092f22d02e8a46216cbf1c8e8101163a:

  ARM: dts: meson8b: fix the clock controller register size (2018-08-29 08:38:21 -0700)

----------------------------------------------------------------
Amlogic DT fixes for v4.19-rc
- meson8b: fix clock controller register sizes
- AXG/s400: enable audio devices

----------------------------------------------------------------
Jerome Brunet (3):
      arm64: dts: meson-axg: add audio fifos
      arm64: dts: meson-axg: s400: enable audio devices
      arm64: dts: meson-axg: s400: add sound card

Martin Blumenstingl (2):
      ARM: dts: meson8: fix the clock controller register size
      ARM: dts: meson8b: fix the clock controller register size

 arch/arm/boot/dts/meson8.dtsi                  |   2 +-
 arch/arm/boot/dts/meson8b.dtsi                 |   2 +-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     |  67 ++++++++++++++++++++++++++
 4 files changed, 249 insertions(+), 2 deletions(-)
