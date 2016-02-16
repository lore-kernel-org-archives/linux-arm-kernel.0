From: majun258@huawei.com (MaJun)
Date: Tue, 16 Feb 2016 14:37:24 +0800
Subject: [PATCH v2 1/5] dt-binding: Change the mbigen binding file to support
 the mbigen-v1
In-Reply-To: <1455604648-20668-1-git-send-email-majun258@huawei.com>
References: <1455604648-20668-1-git-send-email-majun258@huawei.com>
Message-ID: <1455604648-20668-2-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

Add the "hisilicon,mbigen-v1" string in binding file.
Signed-off-by: Ma Jun <majun258@huawei.com>
---
 .../interrupt-controller/hisilicon,mbigen-v2.txt   |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
index 720f7c9..bdd1dea 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
@@ -16,7 +16,7 @@ The mbigen chip and devices connect to mbigen have the following properties:
 
 Mbigen main node required properties:
 -------------------------------------------
-- compatible: Should be "hisilicon,mbigen-v2"
+- compatible: Should be "hisilicon,mbigen-v2" or "hisilicon,mbigen-v1"
 
 - reg: Specifies the base physical address and size of the Mbigen
   registers.
-- 
1.7.1
