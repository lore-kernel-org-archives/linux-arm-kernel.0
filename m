From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 27 Mar 2017 14:18:18 +0100
Subject: [PATCH v3 2/9] Documentation/ABI: add information about cpu_capacity
In-Reply-To: <20170327131825.32134-1-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
Message-ID: <20170327131825.32134-3-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/sys/devices/system/cpu/cpu#/cpu_capacity describe information about
CPUs heterogeneity (ref. to Documentation/devicetree/bindings/arm/
cpu-capacity.txt).

Add such description.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 2a4a423d08e0..f3d5817c4ef0 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -366,3 +366,10 @@ Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
 Description:	AArch64 CPU registers
 		'identification' directory exposes the CPU ID registers for
 		 identifying model and revision of the CPU.
+
+What:		/sys/devices/system/cpu/cpu#/cpu_capacity
+Date:		December 2016
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	information about CPUs heterogeneity.
+
+		cpu_capacity: capacity of cpu#.
-- 
2.10.0
