From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 16 Aug 2017 21:13:27 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.14
Message-ID: <7hr2waal20.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to ec9b59162fd8317933e362f347a7ed6da7d85618:

  ARM: dts: meson6: use stable UART bindings (2017-08-08 14:49:12 -0700)

----------------------------------------------------------------
Amlogic 32-bit DT changes for v4.14
- update clock controler for use as reset controller
- misc. updates/fixups/improvements

----------------------------------------------------------------
Martin Blumenstingl (5):
      ARM: dts: move the pwm_ab and pwm_cd nodes to meson.dtsi
      ARM: dts: meson8: add the PWM controller nodes
      ARM: dts: meson8b: use the existing wdt node to override the compatible
      ARM: dts: meson: add a node which describes the SRAM
      ARM: dts: meson: mark the clock controller also as reset controller

Neil Armstrong (1):
      ARM: dts: meson6: use stable UART bindings

 arch/arm/boot/dts/meson.dtsi   | 30 ++++++++++++++++++++++++++----
 arch/arm/boot/dts/meson6.dtsi  | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8.dtsi  | 16 ++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi | 33 +++++++++++++--------------------
 4 files changed, 83 insertions(+), 24 deletions(-)
