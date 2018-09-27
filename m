From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 27 Sep 2018 22:21:04 +0200
Subject: [GIT PULL] pxa-dt for v4.20
Message-ID: <877ej63d5b.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is a tiny pxa pull request for 4.20 device-tree. Please consider pulling.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-dt-4.20

for you to fetch changes up to 9f296fe2718efe558825471b5cdf0ca4d1bdd3c6:

  ARM: dts: pxa: add pincontrol helpers (2018-08-31 22:29:29 +0200)

----------------------------------------------------------------
This device-tree pxa update brings :
 - a couple of changes for future pxa2xx platforms
  - 2 fixes in RTC and I2C domain

----------------------------------------------------------------
Marcel Ziswiler (1):
      ARM: dts: pxa: fix power i2c base address

Robert Jarzmik (3):
      ARM: dts: pxa: change serial node names
      ARM: dts: pxa: fix the rtc controller
      ARM: dts: pxa: add pincontrol helpers

 arch/arm/boot/dts/pxa25x.dtsi |  4 ++++
 arch/arm/boot/dts/pxa27x.dtsi |  6 +++++-
 arch/arm/boot/dts/pxa2xx.dtsi | 27 +++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
Robert
