From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Thu, 16 Jan 2014 13:44:12 +0100
Subject: [PATCH v4 0/11] iommu/arm-smmu: Misc modifications to support SMMUs
 on Calxeda ECX-2000
Message-ID: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is v4 of arm-smmu changes to support SMMUs on Calxeda ECX-2000.

Patches are based on v3.13-rc8.

Major change to previous version is new code that allows to extend an
existing IOMMU address mapping. (last two patches)

Changelog:
v4:
 - added support to extend the size of an IOMMU address mapping
 - check for duplicate stream IDs
 - Increase MAX_PHANDLE_ARGS
 - misc minor changes of patch
   "iommu/arm-smmu: Introduce automatic stream-id-masking"
v3:
  http://marc.info/?l=linux-arm-kernel&m=138212725606348
v2:
  http://marc.info/?l=linux-arm-kernel&m=138135834704855
v1:
   http://marc.info/?l=linux-arm-kernel&m=138122450023564


Regards,
Andreas
