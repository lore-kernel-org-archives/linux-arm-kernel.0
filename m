From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Jun 2014 13:20:57 -0500
Subject: [PATCH v3 0/2] arm: dts: add support for am437x sk
Message-ID: <1403547659-24558-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here's v3 of am437x sk support. Patches tested on top of next-20140617.

Note that this series was tested with the following extra patches:

http://marc.info/?l=linux-omap&m=140299431732700&w=2
http://marc.info/?l=linux-omap&m=140300146503126&w=2
http://marc.info/?l=linux-omap&m=140299231232123
http://marc.info/?l=linux-omap&m=140310472709968&w=2
http://marc.info/?l=linux-omap&m=140310471409959&w=2

A branch is also available with all these patches at [1].

[1] http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=am437x-starterkit

Felipe Balbi (2):
  arm: dts: am4372: let boards access all nodes through phandles
  arm: dts: add support for AM437x StarterKit

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am4372.dtsi                      |   8 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                | 613 +++++++++++++++++++++
 4 files changed, 621 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/am437x-sk-evm.dts

-- 
2.0.0.390.gcb682f8
