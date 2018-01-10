From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 10 Jan 2018 09:17:41 +0530
Subject: [PATCH V6 12/13] boot_constraint: Update MAINTAINERS
In-Reply-To: <cover.1515554879.git.viresh.kumar@linaro.org>
References: <cover.1515554879.git.viresh.kumar@linaro.org>
Message-ID: <1939c9c38274a92a0a98ec0041fbdfc0981511f3.1515554879.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry for boot constraint subsystem in MAINTAINERS.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b46c9cea5ae5..0b9be1c5a982 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2718,6 +2718,15 @@ S:	Supported
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
