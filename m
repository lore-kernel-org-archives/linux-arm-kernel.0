From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 18 Feb 2011 11:05:51 +0900
Subject: [PATCH 0/2] ARM: Update number of VIC for S5P SoCs
Message-ID: <1297994753-22246-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S5PV210 has 4 VICs and S5P6442 and S5PC100 have 3 VICs.
However, default VIC number is defined 2 in arch/arm/common.
So can be happened some problem on above SoCs.

I know, another better patch which has been submitted for it,
but I couldn't find any its progress, right now, need this
for esp., PM and so on.

And if required, can be improved for it later.

[PATCH RE-SEND 1/2] ARM: Update number of VIC for S5PV210
[PATCH RE-SEND 2/2] ARM: Update number of VIC for S5P6442 and S5PC100
