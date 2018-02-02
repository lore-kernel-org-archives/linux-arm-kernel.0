From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  2 Feb 2018 22:01:50 +0800
Subject: [PATCH 0/3] Allwinner V3s audio codec device tree changes
Message-ID: <20180202140153.21549-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the Allwinner V3s audio codec device tree changes, which used to
be blocked by the DMA engine code.

The first patch adds the DMA engine device tree node, and the second
adds the codec nodes (digital and analog).

The thrid patch is for Lichee Pi Zero with Dock board to enable the
audio jack and on-board mic.

Icenowy Zheng (3):
  ARM: dts: sun8i: add DMA engine in V3s DTSI
  ARM: dts: sun8i: add audio codec support into V3s DTSI
  ARM: sun8i: v3s: enable audio on Lichee Pi Zero Dock board

 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts |  9 +++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 28 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.15.1
