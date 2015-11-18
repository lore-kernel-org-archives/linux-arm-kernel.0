From: jonmason@broadcom.com (Jon Mason)
Date: Wed, 18 Nov 2015 18:13:47 -0500
Subject: [PATCH 0/3] ARM: dts: add support for NS, NSP, and NS2 clocks
Message-ID: <1447888430-4451-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series adds device tree support for the Broadcom Northstar,
Northstar Plus, and Northstar 2 clocks.

Last sent as an RFC (see https://lkml.org/lkml/2015/10/13/882) due to
the inability to merge because of the driver dependencies.  Those
necessary driver changes were merged into 4.4.  All comments have been
addressed and it is ready to be pulled in.


Jon Mason (3):
  ARM: dts: enable clock support for BCM5301X
  ARM: dts: enable clock support for Broadcom NSP
  ARM64: dts: enable clock support for Broadcom NS2

 arch/arm/boot/dts/bcm-nsp.dtsi        | 99 ++++++++++++++++++++++++++---------
 arch/arm/boot/dts/bcm5301x.dtsi       | 92 ++++++++++++++++++++++++--------
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 80 +++++++++++++++++++++++++++-
 3 files changed, 225 insertions(+), 46 deletions(-)

-- 
1.9.1
