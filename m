From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Sep 2010 21:03:11 +0900
Subject: [PATCH 0/2] ARM: Update number of VIC
Message-ID: <1284120193-23291-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches update number of VIC.
The S5PV210 has 4 VICs, and the S5P6442 and S5PC100 have 3 ViCs.
So need to update ARM_VIC_NR for them.

Russell,

How do you think this?
If another better way, please let me know.

Thanks.

[PATCH 1/2] ARM: Update number of VIC for S5PV210
[PATCH 2/2] ARM: Update number of VIC for S5P6442 and S5PC100
