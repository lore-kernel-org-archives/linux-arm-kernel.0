From: thommyj@gmail.com (Thommy Jakobsson)
Date: Thu,  9 Jun 2016 12:43:19 +0200
Subject: [PATCH v3 0/2] arm-smmu: Add possibillity to mask streamIDs
In-Reply-To: <5757FD62.2010403@arm.com>
References: <5757FD62.2010403@arm.com>
Message-ID: <1465469001-2352-1-git-send-email-thommyj@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes it possible to manually set a mask for a master.
Default behaviour when not specifying a mask is to keep current behaviour.
A mask is specified by using upper halw word of the StreamID cell in DT.

Thommy Jakobsson (2):
  arm-smmu: doc: add SMMU mask documentation
  arm-smmu: Add possibillity to mask streamIDs

 .../devicetree/bindings/iommu/arm,smmu.txt         | 23 +++++++++++++++++++---
 drivers/iommu/arm-smmu.c                           | 18 +++++++++++++++--
 2 files changed, 36 insertions(+), 5 deletions(-)

-- 
1.9.1
