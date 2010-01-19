From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Jan 2010 09:43:42 +0100
Subject: [PATCH] arm: add a comment to __atags_pointer describing where it's
	set
In-Reply-To: <20100119083803.GA17904@pengutronix.de>
References: <20100119083803.GA17904@pengutronix.de>
Message-ID: <1263890623-14952-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..84a6e1f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -73,6 +73,10 @@ EXPORT_SYMBOL(__machine_arch_type);
 unsigned int cacheid;
 EXPORT_SYMBOL(cacheid);
 
+/*
+ * This is assigned to in arch/arm/kernel/head-common.S
+ * before calling start_kernel
+ */
 unsigned int __atags_pointer __initdata;
 
 unsigned int system_rev;
-- 
1.6.6
