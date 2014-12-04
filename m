From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 11:01:53 -0600
Subject: [PATCH 0/6] arm: boot: dts: am437x-sk: DTS pinmux fixes
Message-ID: <1417712519-4615-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a small series of non-critical fixes and improvements
for AM437x Starter Kit DTS.

Basically I'm removing unnecessary pulls and adding explicit
pinmux for a couple interfaces which were missing.

All patches tested on top of commit 1ca7c60 (Add linux-next
specific files for 20141204). Boot logs will be attached as
a reply here.

Felipe Balbi (6):
  arm: boot: dts: am437x-sk: remove internal pulls from QSPI
  arm: boot: dts: am437x-sk: add explicit MMC0 pinmux
  arm: boot: dts: am437x-sk: remove ethernet pulls
  arm: boot: dts: am437x-sk: add explicit pinmux for both USB instances
  arm: boot: dts: am437x-sk: remove internal i2c pullups
  arm: boot: dts: am437x-sk: remove DSS pulls

 arch/arm/boot/dts/am437x-sk-evm.dts | 150 +++++++++++++++++++++---------------
 1 file changed, 86 insertions(+), 64 deletions(-)

-- 
2.1.0.GIT
