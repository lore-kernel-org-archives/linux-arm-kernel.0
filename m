From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 28 Feb 2014 16:37:08 +0100
Subject: [PATCH 0/2] ARM SMMU fixes
Message-ID: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

I've studied your arm-smmu driver as a base to write a Renesas IOMMU driver
and found two small issues. Here are patches to fix them. Please bear with me
if my understanding was incorrect and the patches wrong :-)

Laurent Pinchart (2):
  iommu/arm-smmu: Replace list walk with platform driver data
  iommu/arm-smmu: Return 0 on unmap failure

 drivers/iommu/arm-smmu.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

-- 
Regards,

Laurent Pinchart
