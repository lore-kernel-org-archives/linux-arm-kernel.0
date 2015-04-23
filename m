From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 23 Apr 2015 16:02:59 -0700
Subject: [PATCH v2 0/2] ARM: BCM63xx: reboot support
Message-ID: <1429830181-28338-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series allows the use of the generic "syscon-reboot" driver for
Broadcom's BCM63xx ARM-based SoCs.

Let me know your thoughts on this so I can submit these in a future Broadcom
SoC pull request, thanks!

Changes in v2:

- dropped the custom driver and use "syscon-reboot"

Florian Fainelli (2):
  dt-bindings: Add documentation for the BCM63138 timer and
    syscon-reboot
  ARM: dts: BCM63xx: Add timer and syscon-reboot nodes

 .../devicetree/bindings/arm/bcm/brcm,bcm63138.txt  | 33 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm63138.dtsi                    | 12 ++++++++
 2 files changed, 45 insertions(+)

-- 
2.1.0
