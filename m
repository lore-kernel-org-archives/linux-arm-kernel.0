From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 22 Jan 2012 12:13:28 +0100
Subject: [RFC PATCH 02/11] ARM: add device tree blobs to .gitignore
In-Reply-To: <20120122111230.GB14835@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
Message-ID: <1327230817-12855-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*.dtb files are a build result and so should be ignored.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Forwarded: id:1323808612-14976-1-git-send-email-u.kleine-koenig at pengutronix.de
---
 arch/arm/boot/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
index ce1c5ff..3c79f85 100644
--- a/arch/arm/boot/.gitignore
+++ b/arch/arm/boot/.gitignore
@@ -3,3 +3,4 @@ zImage
 xipImage
 bootpImage
 uImage
+*.dtb
-- 
1.7.8.3
