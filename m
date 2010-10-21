From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 09:58:28 +0900
Subject: [PATCH 0/5] ARM: S5P: Update DMA operation clock
Message-ID: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates Peri-DMA (PL330) operation clock on S5P SoCs which
have PL330 DMAC. Basically, registered PDMA clocks as disabled clock
and enabled when called pl330-probe() in s3c-pl330.c.

[PATCH 1/5] ARM: S5P6442: Add DMA operation clock
[PATCH 2/5] ARM: S5PV210: Add DMA operation clock
[PATCH 3/5] ARM: S5P64X0: Set DMA clock disable as default
[PATCH 4/5] ARM: S5P: Reorder DMA platform device id
[PATCH 5/5] ARM: SAMSUNG: Add to enable/disable clock on S3C PL330
