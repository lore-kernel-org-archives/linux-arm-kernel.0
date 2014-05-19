From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 May 2014 13:06:01 -0700
Subject: [PATCH RESEND v2 3/3] Documentation: sysfs: add Broadcom GISB arbiter
 sysfs properties
In-Reply-To: <1400529962-9612-1-git-send-email-f.fainelli@gmail.com>
References: <1400529962-9612-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1400529962-9612-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the sysfs properties exposed by the Broadcom GISB
bus arbiter hardware.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
- respin

 Documentation/ABI/testing/sysfs-platform-brcmstb-gisb-arb | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-gisb-arb

diff --git a/Documentation/ABI/testing/sysfs-platform-brcmstb-gisb-arb b/Documentation/ABI/testing/sysfs-platform-brcmstb-gisb-arb
new file mode 100644
index 000000000000..f1bad92bbe27
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-brcmstb-gisb-arb
@@ -0,0 +1,8 @@
+What:		/sys/devices/../../gisb_arb_timeout
+Date:		May 2014
+KernelVersion:	3.17
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		Returns the currently configured raw timeout value of the
+		Broadcom Set Top Box internal GISB bus arbiter. Minimum value
+		is 1, and maximum value is 0xffffffff.
-- 
1.9.1
