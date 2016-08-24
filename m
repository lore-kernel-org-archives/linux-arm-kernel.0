From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Wed, 24 Aug 2016 15:44:53 +0800
Subject: [PATCH v7 14/14] Documentation: remove the constraint on the
 distances of node pairs
In-Reply-To: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472024693-12912-15-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update documentation. This limit is unneccessary.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/numa.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
index 21b3505..c0ea4a7 100644
--- a/Documentation/devicetree/bindings/numa.txt
+++ b/Documentation/devicetree/bindings/numa.txt
@@ -48,7 +48,6 @@ distance (memory latency) between all numa nodes.

   Note:
 	1. Each entry represents distance from first node to second node.
-	The distances are equal in either direction.
 	2. The distance from a node to self (local distance) is represented
 	with value 10 and all internode distance should be represented with
 	a value greater than 10.
--
2.5.0
