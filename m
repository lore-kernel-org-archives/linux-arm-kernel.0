From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 14 Oct 2009 09:20:17 +0200
Subject: [PATCH 00/10] [ARM] cm-x300 updates for 2.6.33
Message-ID: <cover.1255504387.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch serie updates CM-X300 board support 

Igor Grinberg (10):
  [ARM] pxa/cm-x300: add revision difference handling
  [ARM] pxa/cm-x300: add TDO35S lcd support
  [ARM] pxa/cm-x300: add ac97 controller registration
  [ARM] pxa/cm-x300: add Wi2Wi chip (Bluetooth and WiFi) initialization
  [ARM] pxa/cm-x300: add support for PXA310 cpu
  [ARM] pxa/cm-x300: enable USB port 2 for PXA300
  [ARM] pxa/cm-x300: add da9030 support
  [ARM] pxa/cm-x300: update authors and copyright
  ASoC: finally enable support for eXeda and CM-X300
  [ARM] pxa/cm-x300: update defconfig

 arch/arm/configs/cm_x300_defconfig |  351 ++++++++++++++++++++++++------------
 arch/arm/mach-pxa/Kconfig          |    1 +
 arch/arm/mach-pxa/cm-x300.c        |  223 ++++++++++++++++++++++-
 sound/soc/pxa/Kconfig              |    3 +-
 4 files changed, 456 insertions(+), 122 deletions(-)
