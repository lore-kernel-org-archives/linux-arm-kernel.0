From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 21 May 2014 15:50:19 +0300
Subject: [PATCH 0/6] AM43xx & OMAP5 DSS DT changes
Message-ID: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are the AM43xx and OMAP5 display DT changes again. I've sent the clock
related changes separately, and I removed OMAP5's RFBI node, which depends on
more clock changes. The RFBI driver doesn't work at the moment anyway, so
removing the RFBI node should not be an issue.

Tony, if these look fine (the rfbi change is the only one compared to the
previous versions), can you queue them for 3.16?

 Tomi

Sathya Prakash M R (2):
  ARM: dts: am4372.dtsi: add DSS information
  ARM: dts: am437x-gp-evm: add LCD data

Tomi Valkeinen (4):
  ARM: dts: am43x-epos-evm: add LCD data
  ARM: dts: omap5.dtsi: add DSS nodes
  ARM: dts: omap5-uevm.dts: add tca6424a
  ARM: dts: omap5-uevm.dts: add display nodes

 arch/arm/boot/dts/am4372.dtsi        |  30 +++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts  |  97 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts | 101 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5-uevm.dts     |  89 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi         |  61 +++++++++++++++++++++
 5 files changed, 378 insertions(+)

-- 
1.9.1
