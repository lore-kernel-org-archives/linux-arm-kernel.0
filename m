From: robh@kernel.org (Rob Herring)
Date: Thu,  8 Sep 2016 13:59:33 -0500
Subject: [PATCH 2/3] config: android: set SELinux as default security mode
In-Reply-To: <20160908185934.18098-1-robh@kernel.org>
References: <20160908185934.18098-1-robh@kernel.org>
Message-ID: <20160908185934.18098-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Android won't boot without SELinux enabled, so make it the default.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 kernel/configs/android-base.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/configs/android-base.config b/kernel/configs/android-base.config
index 19eb7ac..859fa27 100644
--- a/kernel/configs/android-base.config
+++ b/kernel/configs/android-base.config
@@ -18,6 +18,7 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CP15_BARRIER_EMULATION=y
+CONFIG_DEFAULT_SECURITY_SELINUX=y
 CONFIG_EMBEDDED=y
 CONFIG_FB=y
 CONFIG_HIGH_RES_TIMERS=y
-- 
2.9.3
