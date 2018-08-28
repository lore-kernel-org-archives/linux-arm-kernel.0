From: dantuguf14105@gmail.com (Neeraj Dantu)
Date: Tue, 28 Aug 2018 16:37:58 +0000
Subject: [PATCH v2] Fix file permission for am335x-osd3358-sm-red.dts
Message-ID: <20180828163758.1305-1-neeraj.dantu@octavosystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix wrong mode for dts file added by 
commit bb3e3fbbac862fa72951283e3632e1cf21a68223
("ARM: dts: Add DT support for Octavo Systems OSD3358-SM-RED
based on TI AM335x").

Signed-off-by: Neeraj Dantu <neeraj.dantu@octavosystems.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Robert Nelson <robertcnelson@gmail.com>
CC: Jason Kridner <jkridner@gmail.com>
---
Changes in v2:
- Fix patch description
---
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts

diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
old mode 100755
new mode 100644
-- 
2.7.4
