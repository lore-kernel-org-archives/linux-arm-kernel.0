From: razvan.stefanescu@nxp.com (Razvan Stefanescu)
Date: Tue, 19 Sep 2017 12:01:38 +0300
Subject: [PATCH 6/6] staging: fsl-dpaa2/ethsw: Add TODO
In-Reply-To: <1505811698-7338-1-git-send-email-razvan.stefanescu@nxp.com>
References: <1505811698-7338-1-git-send-email-razvan.stefanescu@nxp.com>
Message-ID: <1505811698-7338-7-git-send-email-razvan.stefanescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a TODO file describing what needs to be added/changed before the driver
can be moved out of staging.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/TODO | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/TODO

diff --git a/drivers/staging/fsl-dpaa2/ethsw/TODO b/drivers/staging/fsl-dpaa2/ethsw/TODO
new file mode 100644
index 0000000..d3f12c3
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/TODO
@@ -0,0 +1,14 @@
+* Add I/O capabilities on switch port netdevices. This will allow control
+traffic to reach the CPU.
+* Add ACL to redirect control traffic to CPU.
+* Add support for displaying learned FDB entries
+* MC firmware uprev; the DPAA2 objects used by the Ethernet Switch driver
+need to   be kept in sync with binary interface changes in MC
+* refine README file
+* cleanup
+
+NOTE: At least first three of the above are required before getting the
+DPAA2 Ethernet Switch driver out of staging. Another requirement is that
+the fsl-mc bus driver is moved to drivers/bus and dpio driver is moved to
+drivers/soc (this is required for I/O).
+
-- 
1.9.1
