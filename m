From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 30 Apr 2016 21:31:18 +0200
Subject: [GIT PULL] pxa-dt for v4.7
Message-ID: <8760uyrj09.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.7 device-tree. It is a tiny collection of
fixes and pin control addition. Can you please consider pulling ?

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-dt-4.7

for you to fetch changes up to fca43c3f7e6fe421194e9b21eabc72604edac16c:

  ARM: dts: pxa3xx: add pincontrol helpers (2016-04-20 20:20:26 +0200)

----------------------------------------------------------------
This device-tree pxa update brings :
 - pin control nodes for pxa2xx and pxa3xx
 - the LCD controller for pxa2xx
 - the missing pxa3xx pulse width modulator nodes
 - an USB Host fix for pxa3xx

----------------------------------------------------------------
Robert Jarzmik (6):
      ARM: dts: pxa: add pxa framebuffer device
      ARM: dts: pxa: add pxa3xx pwm nodes
      ARM: dts: add pincontroller to pxa27x
      ARM: dts: pxa: fix the ohci clock for pxa3xx
      ARM: dts: pxa: add pinctrl to pxa3xx
      ARM: dts: pxa3xx: add pincontrol helpers

 arch/arm/boot/dts/pxa27x.dtsi |   7 +++
 arch/arm/boot/dts/pxa2xx.dtsi |   8 +++
 arch/arm/boot/dts/pxa3xx.dtsi | 133 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 147 insertions(+), 1 deletion(-)

-- 
Robert
