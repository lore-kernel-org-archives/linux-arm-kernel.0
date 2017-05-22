From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Mon, 22 May 2017 15:09:33 +0300
Subject: [PATCH 3/5] staging: fsl-mc: drop reference to restool
In-Reply-To: <20170522120935.4119-1-laurentiu.tudor@nxp.com>
References: <20170522120935.4119-1-laurentiu.tudor@nxp.com>
Message-ID: <20170522120935.4119-4-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Drop reference to user space restool utility from the README.
It will be added back together with the actual support in the
bus driver.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/README.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-mc/README.txt b/drivers/staging/fsl-mc/README.txt
index 179536a..d7cd70a 100644
--- a/drivers/staging/fsl-mc/README.txt
+++ b/drivers/staging/fsl-mc/README.txt
@@ -131,9 +131,7 @@ in creating a network interfaces.
 
     DPRCs can be defined statically and populated with objects
     via a config file passed to the MC when firmware starts
-    it.  There is also a Linux user space tool called "restool"
-    that can be used to create/destroy containers and objects
-    dynamically.
+    it.
 
 -DPAA2 Objects for an Ethernet Network Interface
 
-- 
2.9.4
