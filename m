From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Nov 2018 08:43:44 +0100
Subject: [GIT PULL] Versatile Express DTS updates
Message-ID: <CACRpkdZY8bybYjZ2zZfgWDLfd0o8zkhrpScAQ+z9xTgzsf0=FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

I agreed with Liviu Dudau (ARM Versatile Express maintainer)
that I will send the Versatile Express updates to ARM SoC.

This is an update of the DTS files (based on my v7 patch set)
that forms the base changes for switch Versatile Express reference
design family over to using DRM with the PL11x driver.

Please pull it in to ARM SoC DTS changes for v4.21!

A corresponding defconfig update activating the new DRM
driver is coming in a few minutes.

Yours,
Linus Walleij

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/vexpress-drm-arm-soc

for you to fetch changes up to f1fe12c8bf33241e04c57a0fc5b25b16ba77ba2d:

  ARM: dts: Modernize the Vexpress PL111 integration (2018-11-29 08:31:41 +0100)

----------------------------------------------------------------
Versatile Express DTS update for DRM:
This updates the Versatile Express family DTS files to
contain the correct and detailed information required
for the PL11x DRM driver to work properly.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: dts: Modernize the Vexpress PL111 integration

 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            | 49 ++++++-----------
 arch/arm/boot/dts/vexpress-v2m.dtsi                | 63 +++++++++++-----------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        | 14 +++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         | 14 +++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            | 14 +++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             | 43 +++++++--------
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         | 23 ++++++++
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   | 37 ++-----------
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      | 14 +++++
 9 files changed, 150 insertions(+), 121 deletions(-)
