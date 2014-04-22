From: marek@goldelico.com (Marek Belisko)
Date: Tue, 22 Apr 2014 23:12:46 +0200
Subject: [PATCH 0/2] Add display support for gta04 device
Message-ID: <1398201168-25275-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This 2 patches adding display support for openmoko gta04 device.
First patch add DT bindings for topolly td028 panel and second add description for
dss + panel.

Marek Belisko (2):
  omapdss: panel-tpo-td028ec1: Add DT support.
  ARM: dts: oma3-gta04: Add display support

 .../bindings/video/toppoly,td028ttec1.txt          | 30 ++++++++
 arch/arm/boot/dts/omap3-gta04.dts                  | 86 ++++++++++++++++++++++
 .../omap2/displays-new/panel-tpo-td028ttec1.c      | 32 +++++++-
 3 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/video/toppoly,td028ttec1.txt

-- 
1.8.3.2
