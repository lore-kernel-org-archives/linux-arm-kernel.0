From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 03 Feb 2017 11:00:22 -0800
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.11, round 2
Message-ID: <7hmve3umk9.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A couple more DT updates for v4.11 on top of the previous pull request.

Please pull,  Thanks.

Kevin


The following changes since commit 249a2243e97edcd2cb0bef01a934d4ba21fb167f:

  ARM64: dts: meson-gxl: add the pwm_ao_b pin (2017-01-27 11:00:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2

for you to fetch changes up to 6b6a1867667a90f399762dc1ee6add5b4aa646c9:

  ARM64: dts: meson-gxbb-p200: add ADC laddered keys (2017-01-30 10:47:59 -0800)

----------------------------------------------------------------
Amlogic DT updates for v4.11, round 2
- add SAR ADC driver
- add ADC laddered keys to meson-gxbb-p200 board

----------------------------------------------------------------
Martin Blumenstingl (1):
      ARM64: dts: meson: meson-gx: add the SAR ADC

Neil Armstrong (1):
      ARM64: dts: meson-gxbb-p200: add ADC laddered keys

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi       |  8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi     | 10 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi      | 10 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi      |  4 ++++
 5 files changed, 82 insertions(+)
