From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Jun 2014 10:43:18 -0500
Subject: [PATCH v2 0/2] arm: dts: add support for am437x sk
Message-ID: <1403106200-777-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here's v2 of am437x sk support. Patches tested on top of next-20140617.

Note that this series was tested with the following extra patches:

http://marc.info/?l=linux-omap&m=140299431732700&w=2
http://marc.info/?l=linux-omap&m=140300146503126&w=2
http://marc.info/?l=linux-omap&m=140299231232123
http://marc.info/?l=linux-omap&m=140310472709968&w=2
http://marc.info/?l=linux-omap&m=140310471409959&w=2

A branch is also available with all these patches at [1] and serial console
capture is available at [2].

[1] http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=am437x-starterkit
[2] http://slexy.org/view/s20wyUDXDh

Felipe Balbi (2):
  arm: dts: am4372: let boards enable RTC and Watchdog
  arm: dts: add support for AM437x StarterKit

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am4372.dtsi                      |   4 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                | 583 +++++++++++++++++++++
 4 files changed, 589 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/am437x-sk-evm.dts

-- 
2.0.0.rc1
