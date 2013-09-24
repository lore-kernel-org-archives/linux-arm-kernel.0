From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue, 24 Sep 2013 17:06:54 +0200
Subject: [PATCH 0/7]: iommu/arm-smmu: Misc fixes/adaptions
Message-ID: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Following patches fix misc issues, that I've seen when using arm-smmu
driver with MMU-400.

I also suggest to add an option to automatically create domains for
each master of detected SMMUs. (Similar to what is available for other
iommu driver(s).)

Comments welcome.


Regards,

Andreas

PS: Patches are against v3.12-rc1-336-gd8524ae (and yes I probably
    need to rebase against Joerg's or your smmu tree but I wanted to
    sent this out to get feedback as soon as possible.)
