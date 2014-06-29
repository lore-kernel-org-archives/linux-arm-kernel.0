From: carlo@caione.org (Carlo Caione)
Date: Sun, 29 Jun 2014 20:23:55 +0200
Subject: [PATCH v7 4/6] input: misc: Add ABI docs for AXP20x PEK
In-Reply-To: <1404066237-20234-1-git-send-email-carlo@caione.org>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
Message-ID: <1404066237-20234-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ABI entries for the PEK found on PMU X-Powers AXP202 and AXP209.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 Documentation/ABI/testing/sysfs-driver-input-axp-pek | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek

diff --git a/Documentation/ABI/testing/sysfs-driver-input-axp-pek b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
new file mode 100644
index 0000000..080563b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
@@ -0,0 +1,11 @@
+What:		/sys/class/input/input(x)/startup
+Date:		March 2014
+Contact:	Carlo Caione <carlo@caione.org>
+Description:	Startup time in us. Board is powered on if the button is pressed
+		for more than <startup_time>
+
+What:		/sys/class/input/input(x)/shutdown
+Date:		March 2014
+Contact:	Carlo Caione <carlo@caione.org>
+Description:	Shutdown time in us. Board is powered off if the button is pressed
+		for more than <shutdown_time>
-- 
1.9.1
