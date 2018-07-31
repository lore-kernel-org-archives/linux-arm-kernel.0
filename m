From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 31 Jul 2018 15:48:02 -0500
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.19 round 3/late
Message-ID: <7htvofyvwd.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Arnd,

Here's a final, late pull for Amlogic DT64, based on top of my round 2
redo.

The audio drivers ended up being merged for v4.19, so wanted to get
these in if at all possible also.

If it's too late for the normal DT pulls, feel free to include in a late
cycle, otherwise I'll (re)send after -rc1.

Thanks,

Kevin




The following changes since commit aaa080fa7e0f01f7cd8eb22a7385a4d8106c7478:

  ARM64: dts: meson-gxl: add support for the Oranth Tanix TX3 Mini (2018-07-20 09:02:22 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-3

for you to fetch changes up to f2ac479f0da046097258c68ef834af01b568436a:

  arm64: dts: meson-axg: add spdif-dit codec (2018-07-25 04:38:22 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.19, round 3
- add DT support for AXG Audio

----------------------------------------------------------------
Jerome Brunet (11):
      arm64: dts: meson-axg: improve power supplies description
      arm64: dts: meson-axg: add vcc 5v regulator on the s400
      arm64: dts: meson-axg: add usb power regulator
      arm64: dts: meson-axg: add audio arb reset controller
      arm64: dts: meson-axg: add spdifout
      arm64: dts: meson-axg: add tdmin formatters
      arm64: dts: meson-axg: add tdmout formatters
      arm64: dts: meson-axg: add tdm interfaces
      arm64: dts: meson-axg: add linein codec
      arm64: dts: meson-axg: add lineout codec
      arm64: dts: meson-axg: add spdif-dit codec

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  57 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 149 +++++++++++++++++++++++++
 2 files changed, 206 insertions(+)
