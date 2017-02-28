From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Tue, 28 Feb 2017 16:52:10 +0100
Subject: [PATCH 0/2] ARM: dts: socfpga: Add support for PMU on Arria5/Cyclone5
Message-ID: <1488297132-21553-1-git-send-email-florian.vaussard@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add suport for ARM Performance Monitor Units on Arria5 and
Cyclone5 SoCFPGA. This was tested on a Cyclone 5 SoC DK board.

Side note: the same change can be probably applied to Arria10 as well,
but we do not have the hardware here to test.

Regards,
Florian

Florian Vaussard (2):
  ARM: dts: socfpga: Add labels for CPU nodes
  ARM: dts: socfpga: Add support for PMU

 arch/arm/boot/dts/socfpga.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.7.4
