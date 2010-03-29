From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Mon, 29 Mar 2010 15:14:10 -0700
Subject: [PATCH 0/2] bcmring: update defconfig and fix semaphore in
 dma.c
Message-ID: <20100329221410.GA24565@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated the bcmring_defconfig to fix the Kautobuild errors.
Also fix a missing down in semaphore in dma.c

[PATCH 1/2] bcmring: update bcmring_defconfig to latest version
[PATCH 2/2] bcmring: fix missing down on semaphore in dma.c

 arch/arm/mach-bcmring/dma.c |   13 ++++++++++---
 arch/arm/configs/bcmring_defconfig |  126 +++++++++++++++++++++++++++++-------
-- 

Leo Hao Chen

------------------------
Broadcom Canada
