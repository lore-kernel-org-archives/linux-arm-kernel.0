From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue,  8 Oct 2013 11:27:19 +0200
Subject: [PATCH 0/5] iommu/arm-smmu: Misc modifications to support SMMUs on
 Calxeda ECX-2000
Message-ID: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Here is a reworked patch set
- to introduce device isolation (using bus-notifier).
- to work around secure-only config access to SMMU registers
- (new) to support masking of all streamIDs for an SMMU
- add DT information for SMMUs on Calxeda ECX-2000

I've also separated out the introduction of driver options handling.
(Just in case it doesn't please you...)

I still need to add the documentation for the introduced SMMU options
to Documentation/devicetree/bindings/iommu/arm,smmu.txt. But first I'd
like to know whether addition of the 3 options is acceptable.

Comments welcome.


Thanks,

Andreas
