From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 16:16:44 +0100
Subject: [PATCH 0/3] arm64: marvell: additional DT changes for Armada 7K/8K
Message-ID: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear mvebu maintainers,

This small set of three patches apply on top of the changes already
merged in the mvebu/dt64 branch, and make some changes to the 7K/8K
Device Trees:

 - Document that the DT bindings for this platform are unstable.

 - Adjust the armada-ap806.dtsi to the clock DT binding change which
   was requested by Rob Herring.

 - Re-order DT nodes by unit address.

Thanks!

Thomas

Thomas Petazzoni (3):
  dt-bindings: arm/marvell: ABI unstability warning about Marvell 7K/8K
  arm64: marvell: update Armada AP806 clock description
  arm64: marvell: re-order Device Tree nodes for Armada AP806

 .../bindings/arm/marvell/armada-7k-8k.txt          | 12 +++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 93 +++++++++++-----------
 2 files changed, 60 insertions(+), 45 deletions(-)

-- 
2.6.4
