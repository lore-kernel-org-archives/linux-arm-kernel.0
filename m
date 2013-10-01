From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue,  1 Oct 2013 14:39:04 +0200
Subject: [PATCH 0/6] iommu/arm-smmu: Misc changes
Message-ID: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here a reworked set of patches. Hopefully all comments addressed.

I omitted the patch "ARM: dma-mapping: Always pass proper prot flags
to iommu_map()" as it is pushed by Marek to the dma-mapping fixes
branch.

I also omitted the device isolation patch (have to think about your
comment(s) and working on a bus notifier version) and ECX-2000 dts
change.


Regards,

Andreas
