From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 14 Nov 2014 11:08:48 +0100
Subject: [PATCH 0/4] ARM: at91/dt: define RTT nodes
Message-ID: <1415959732-13591-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series define RTT and GPBR devices on all at91 SoCs
embedding those blocks and enable them on the at91sam9g20ek and
at91sam9m10g45ek boards (which are the boards I tested on).

Best Regards,

Boris

Boris Brezillon (4):
  ARM: at91/dt: add RTT nodes to at91 dtsis
  ARM: at91/dt: add GPBR nodes
  ARM: at91/dt: enable the RTT block on the sam9g20ek board
  ARM: at91/dt: enable the RTT block on the at91sam9m10g45ek board

 arch/arm/boot/dts/at91sam9260.dtsi          | 14 ++++++++++++++
 arch/arm/boot/dts/at91sam9261.dtsi          | 14 ++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi          | 21 +++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi          | 14 ++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |  9 +++++++++
 arch/arm/boot/dts/at91sam9rl.dtsi           | 14 ++++++++++++++
 7 files changed, 100 insertions(+)

-- 
1.9.1
