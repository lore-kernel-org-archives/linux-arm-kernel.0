From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 17 Nov 2015 15:37:44 -0700
Subject: [PATCH RFC 20/27] Documentation: ARM: topology: 'cluster' property
 for cluster nodes
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1447799871-56374-21-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a place holder phandle for a cluster to define cluster specific
properties like PM domain definitions etc.

Cc: Rob Herring <robherring2@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/devicetree/bindings/arm/topology.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
index 1061faf..12b4082 100644
--- a/Documentation/devicetree/bindings/arm/topology.txt
+++ b/Documentation/devicetree/bindings/arm/topology.txt
@@ -109,6 +109,14 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
 	The cluster node name must be "clusterN" as described in 2.1 above.
 	A cluster node can not be a leaf node.
 
+	Properties for a cluster node are -
+
+	-cluster
+		Usage: Optional
+		Value type: <phandle>
+		Definition: a phandle to a cluster node that corresponds to
+			    this cluster.
+
 	A cluster node's child nodes must be:
 
 	- one or more cluster nodes; or
-- 
2.1.4
