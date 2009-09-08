From: thomas.ab@samsung.com (thomas.ab at samsung.com)
Date: Tue,  8 Sep 2009 14:24:59 +0900
Subject: [PATCH 0/4] s3c6410: Samsung 6410 clock configuration fixes.
Message-ID: <1252387499-9200-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch series fixes issues in the Samsung's 6410 clock configuration
code. These patches are required for the correct functioning of the 
s3c6410 SDHCI driver. The following patches are included in this 
patch series.

[PATCH 1/4] s3c6410: use correct divider_shift in setrate_clksrc()
[PATCH 2/4] s3c6410: update clk->parent when setting clock source
[PATCH 3/4] s3c6410: Fix divider value calculation in s3c64xx_roundrate_clksrc
[PATCH 4/4] s3c6410: Remove redundant mpll parent assignment.

--
1.5.3.4
