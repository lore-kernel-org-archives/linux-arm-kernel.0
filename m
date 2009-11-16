From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:35:08 +0100
Subject: [PATCH 25/25] imx/mx25pdk: remove unused include
In-Reply-To: <1258403708-10287-24-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-20-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-21-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-22-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-23-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-24-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-25-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/mx25pdk.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx25/mx25pdk.c b/arch/arm/mach-mx25/mx25pdk.c
index d23ae57..9bfa408 100644
--- a/arch/arm/mach-mx25/mx25pdk.c
+++ b/arch/arm/mach-mx25/mx25pdk.c
@@ -33,7 +33,6 @@
 #include <mach/common.h>
 #include <mach/imx-uart.h>
 #include <mach/mx25.h>
-#include <mach/mxc_nand.h>
 #include "devices.h"
 #include <mach/iomux-v3.h>
 
-- 
1.6.5.2
