From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 19 Dec 2013 23:01:56 +0100
Subject: [PATCHv1 0/3] Enable ISL12057 RTC chip in ReadyNAS .dts files
Message-ID: <cover.1387490258.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Now that support for ISL12057 RTC chip is on track for in v3.14, the
three patches in this series simply reference the chip in NETGEAR
ReadyNAS 102, 104 and 2120 .dts files so that the device stop booting
in the 70's. 

Jason, can you queue those for v3.14? The patches are based on your
mvebu/dt branch to simplify your work.

Arnaud Ebalard (3):
  ARM: mvebu: Enable ISL12057 RTC chip in ReadyNAS 102 .dts file
  ARM: mvebu: Enable ISL12057 RTC chip in ReadyNAS 104 .dts file
  ARM: mvebu: Enable ISL12057 RTC chip in ReadyNAS 2120 .dts file

 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 5 +++++
 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 5 +++++
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 5 +++++
 3 files changed, 15 insertions(+)

-- 
1.8.4.4
