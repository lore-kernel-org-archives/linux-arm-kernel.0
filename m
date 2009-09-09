From: laforge@gnumonks.org (laforge at gnumonks.org)
Date: Wed,  9 Sep 2009 20:03:36 +0900
Subject: [PATCH 0/3] [ARM] Watchdog support for Samsung 6410 SoC
Message-ID: <1252494216-6434-1-git-send-email-laforge@gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Harald Welte <laforge@gnumonks.org>

This patch series extends the existing watchdog timer support on
Samsung 24xx SoC's to Samsung 6410 SoC. This patch series includes
the following patches.

[PATCH 1/3] [ARM] s3c: move watchdog dev from plat-24xx into plat-s3c
[PATCH 2/3] watchdog: Samsung SoC Watchdog is not s3c24xx specific
[PATCH 3/3] [ARM] Enable watchdog platform device on SMDK6410 

-- 
1.5.3.4
