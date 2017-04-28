From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Fri, 28 Apr 2017 04:50:33 -0500
Subject: [PATCH v3 8/9] staging: fsl-dpaa2/eth: Add TODO file
In-Reply-To: <20170428095034.8842-1-ruxandra.radulescu@nxp.com>
References: <20170428095034.8842-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170428095034.8842-9-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a list of TODO items for the Ethernet driver

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
v3: Add contact info
v2: Add note

 drivers/staging/fsl-dpaa2/ethernet/TODO | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/TODO

diff --git a/drivers/staging/fsl-dpaa2/ethernet/TODO b/drivers/staging/fsl-dpaa2/ethernet/TODO
new file mode 100644
index 000000000000..110e66d44b42
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethernet/TODO
@@ -0,0 +1,18 @@
+* Add a DPAA2 MAC kernel driver in order to allow PHY management; currently
+  the DPMAC objects and their link to DPNIs are handled by MC internally
+  and all PHYs are seen as fixed-link
+* add more debug support: decide how to expose detailed debug statistics,
+  add ingress error queue support
+* MC firmware uprev; the DPAA2 objects used by the Ethernet driver need to
+  be kept in sync with binary interface changes in MC
+* refine README file
+* cleanup
+
+NOTE: None of the above is must-have before getting the DPAA2 Ethernet driver
+out of staging. The main requirement for that is to have the drivers it
+depends on, fsl-mc bus and DPIO driver, moved to drivers/bus and drivers/soc
+respectively.
+
+ Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
+ ruxandra.radulescu at nxp.com, devel at driverdev.osuosl.org,
+ linux-kernel at vger.kernel.org
-- 
2.11.0
