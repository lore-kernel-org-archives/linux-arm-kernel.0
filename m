From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 Dec 2017 21:03:19 +0530
Subject: [PATCH V5 12/13] boot_constraint: Update MAINTAINERS
In-Reply-To: <cover.1513264961.git.viresh.kumar@linaro.org>
References: <cover.1513264961.git.viresh.kumar@linaro.org>
Message-ID: <3037a6e5fb72f922b479f882fa710e60097c9f6c.1513264961.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry for boot constraint subsystem in MAINTAINERS.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e716cdafa784..81823de0d655 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2723,6 +2723,15 @@ S:	Supported
 F:	drivers/net/bonding/
 F:	include/uapi/linux/if_bonding.h
 
+BOOT CONSTRAINT SUBSYSTEM
+M:	Viresh Kumar <vireshk@kernel.org>
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+T:	git git://git.linaro.org/people/vireshk/linux.git
+F:	Documentation/driver-api/boot_constraint/
+F:	drivers/boot_constraint/
+F:	include/linux/boot_constraint.h
+
 BPF (Safe dynamic programs and tools)
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
-- 
2.15.0.194.g9af6a3dea062
