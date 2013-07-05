From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:24 -0300
Subject: [PATCH v6 13/21] bus: mvebu-mbus: Update main description
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-14-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

After replacing the MBus name-based by the new ID-based API
let's fix the general description of the driver at the beginning
of the file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 8240bd7..58d3c8f 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -35,13 +35,9 @@
  *
  * - Provides an API for platform code or device drivers to
  *   dynamically add or remove address decoding windows for the CPU ->
- *   device accesses. This API is mvebu_mbus_add_window(),
- *   mvebu_mbus_add_window_remap_flags() and
- *   mvebu_mbus_del_window(). Since the (target, attribute) values
- *   differ from one SoC family to another, the API uses a 'const char
- *   *' string to identify devices, and this driver is responsible for
- *   knowing the mapping between the name of a device and its
- *   corresponding (target, attribute) in the current SoC family.
+ *   device accesses. This API is mvebu_mbus_add_window_by_id(),
+ *   mvebu_mbus_add_window_remap_by_id() and
+ *   mvebu_mbus_del_window().
  *
  * - Provides a debugfs interface in /sys/kernel/debug/mvebu-mbus/ to
  *   see the list of CPU -> SDRAM windows and their configuration
-- 
1.8.1.5
