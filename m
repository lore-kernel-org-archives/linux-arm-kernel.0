From: jelle@vdwaa.nl (Jelle van der Waa)
Date: Thu, 23 Mar 2017 22:24:43 +0100
Subject: [PATCH v2 0/1] ARM: dts: sun8i: NanoPi NEO Air add WiFi / eMMC
Message-ID: <20170323212444.20685-1-jelle@vdwaa.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the WiFi (AP6212) chip and eMMC support for the NanoPi NEO Air.

---
Fixes in v2:
- Rename underscore nodes
- Remove allwinner prefix from GPIO node and use generic properties

Jelle van der Waa (1):
  ARM: dts: sun8i: NanoPi NEO Air add WiFi / eMMC

 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

-- 
2.12.1
