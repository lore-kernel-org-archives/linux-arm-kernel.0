From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Mar 2012 10:54:15 -0700
Subject: [GIT PULL] A few more dt patches for tegra
Message-ID: <CAOesGMgrx3VK0Om8KoSMh8=7+EmW-P-ZqmXKLNDO6mw4g3yrFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I have a few more patches on top of the branch already pulled into
tegra/dt in arm-soc. Please pull these ones on top of the existing
contents.

Thanks!


-Olof

The following changes since commit 96d6714ca27acab087dcc8d75a7ec815abe3dde7:

  ASoC: DT: Add digital microphone binding to PAZ00 board. (2012-03-04
10:42:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.4/dt

for you to fetch changes up to 0a428036dfb28be3e5f0d671e3457509d1f4ea29:

  arm: tegra: dts: Mark USB1 as an OTG port on Seaboard (2012-03-07
14:36:56 -0800)

----------------------------------------------------------------
Simon Glass (3):
      arm: tegra: dts: Support host/device selection and legacy mode
      arm: tegra: dts: Add legacy mode support to Tegra2x USB1 port
      arm: tegra: dts: Mark USB1 as an OTG port on Seaboard

 Documentation/devicetree/bindings/usb/tegra-usb.txt |   13 +++++++++++++
 arch/arm/boot/dts/tegra-seaboard.dts                |    1 +
 arch/arm/boot/dts/tegra20.dtsi                      |    1 +
 3 files changed, 15 insertions(+)
