From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  8 Jul 2016 11:48:50 -0700
Subject: [PATCH 0/2] ARM: dts: NSP: Add built-in Ethernet switch nodes
Message-ID: <1468003735-26895-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is based on Broadcom/stblinux/devicetree/next which
contains proper support for the BCM958625HR board. To get working
Ethernet switch and CPU Ethernet support, the following dependencies
based on David Miller's net-next tree are required:

- Jon Mason's BGMAC/AMAC support: https://marc.info/?t=146793308300002&r=1&w=3
- dsa/b53 support for NSP switch: https://marc.info/?l=linux-netdev&m=146800324531914&w=3

Florian Fainelli (2):
  ARM: dts: NSP: Add Switch Register Access Block node
  ARM: dts: NSP: Add BCM958625HR switch ports

 arch/arm/boot/dts/bcm-nsp.dtsi    | 11 +++++++++
 arch/arm/boot/dts/bcm958625hr.dts | 49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
2.7.4
