From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 28 May 2010 11:41:13 +0900
Subject: [PATCH] Updates for S3C HSOTG driver
Message-ID: <1275014477-23133-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the following updates for S3C HSTOG driver.
1. Adds HCLK clock for S3C HSOTG module.
2. Adds clk_xusbxti clock to the list of clocks to be registred in S5P.
3. Sets the clk_xusbsti clock rate on S5PV210 to 24Mhz.
4. Updates the s3c hsotg driver to use the HCLK OTG clock.

[PATCH 1/4] ARM: S3C64XX: Add USB OTG HCLK to the list of clocks
[PATCH 2/4] ARM: S5PV210: Assign clock rate for clk_xusbxti clock.
[PATCH 3/4] ARM: S5P: Add clk_xusbxti clock to the list of clocks to be registered.
[PATCH 4/4] usb: s3c-hsotg: Enable HCLK for the OTG module.
