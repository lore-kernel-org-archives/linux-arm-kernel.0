From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Aug 2010 21:33:45 +0900
Subject: [PATCH 0/3] ARM: S5PV310: Add support HSMMC on SMDKC210 and SMDKV310
Message-ID: <1282307628-5254-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes HSMMC interrupt name and adds initial map for GPIO2 and GPIO3
so that can support 4 HSMMC on SMDKC210 and SMDKV310.

NOTE: depends on Kyungmin's 'Fix on GPIO base addresses'

[PATCH 1/3] ARM: SAMSUNG: Change the 3rd HSMMC interrupt name for compatibility
[PATCH 2/3] ARM: S5P: Add initial map for GPIO2 and GPIO3
[PATCH 3/3] ARM: S5PV310: Add support HSMMC on SMDKC210 and SMDKV310
