From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Sun, 30 Nov 2014 21:46:38 -0600
Subject: [PATCH 0/2] arm64: amd-seattle: Misceleneous DT fix up
Message-ID: <1417405600-19232-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set mainly fixes up the dma-ranges and pci bus range.
Please see each patch for more details.

Suravee Suthikulpanit (2):
  arm64: amd-seattle: Fix dma-ranges property
  arm64: amd-seattle: Fix PCI bus range due to SMMU limitation

 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
1.9.3
