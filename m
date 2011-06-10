From: robherring2@gmail.com (Rob Herring)
Date: Fri, 10 Jun 2011 15:48:41 -0500
Subject: [PATCH v4 2/4] dt: add EXPORT_SYMBOL to of_platform_populate
In-Reply-To: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
Message-ID: <1307738923-7564-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

of_platform_populate is missing an EXPORT_SYMBOL, so add it.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/of/platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index dc56a77..8d0f477 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -328,4 +328,5 @@ int of_platform_populate(struct device_node *root,
 	of_node_put(root);
 	return rc;
 }
+EXPORT_SYMBOL(of_platform_populate);
 #endif /* !CONFIG_SPARC */
-- 
1.7.4.1
