From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Jun 2010 07:31:54 +0900
Subject: [PATCH] ARM: S5P: Add Support common arch_reset() for S5P SoCs
Message-ID: <1277332317-30192-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds system define for arch_reset() for S5P SoCs
such as S5P6440, S5P6442, S5PC100 and S5PV210/S5PC110.
Now perform reset using Watchdog reset, SWRESET support with
s5p_reset_hook() will be added later.

NOTE: depends on 'Add Watchdog support for S5PC100'

ARM: S5P6442: Add Watchdog Timer map for S5P6442
ARM: S5P: Add System define for arch_reset()
ARM: S5P: Add Support common arch_reset() for S5P SoCs
