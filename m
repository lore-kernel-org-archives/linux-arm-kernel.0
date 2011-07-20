From: per.forlin@linaro.org (Per Forlin)
Date: Thu, 21 Jul 2011 00:02:01 +0200
Subject: [PATCH v3 3/3] fault injection: add documentation on MMC IO fault
	injection
In-Reply-To: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
References: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
Message-ID: <1311199321-4618-4-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description on how to enable random fault injection
for MMC IO

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 Documentation/fault-injection/fault-injection.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/fault-injection/fault-injection.txt b/Documentation/fault-injection/fault-injection.txt
index 7be15e4..27eede4 100644
--- a/Documentation/fault-injection/fault-injection.txt
+++ b/Documentation/fault-injection/fault-injection.txt
@@ -21,6 +21,11 @@ o fail_make_request
   /sys/block/<device>/make-it-fail or
   /sys/block/<device>/<partition>/make-it-fail. (generic_make_request())
 
+o fail_mmc_request
+
+  injects MMC data errors on devices permitted by setting
+  /sys/kernel/debug/mmc0/make-it-fail
+
 Configure fault-injection capabilities behavior
 -----------------------------------------------
 
-- 
1.7.4.1
