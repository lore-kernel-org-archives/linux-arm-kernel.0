From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  7 Nov 2017 14:28:10 -0800
Subject: [PATCH 0/2] ARM: dts: NSP fixes
Message-ID: <20171107222812.17267-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series contains a couple of fixes:

- disables AHCI on NSP HR boards since that results in a hard hang
- fixes PPI interrupts specifiers

Florian Fainelli (2):
  ARM: dts: NSP: Disable AHCI controller for HR NSP boards
  ARM: dts: NSP: Fix PPI interrupt types

 arch/arm/boot/dts/bcm-nsp.dtsi    | 4 ++--
 arch/arm/boot/dts/bcm958623hr.dts | 4 ----
 arch/arm/boot/dts/bcm958625hr.dts | 4 ----
 3 files changed, 2 insertions(+), 10 deletions(-)

-- 
2.9.3
