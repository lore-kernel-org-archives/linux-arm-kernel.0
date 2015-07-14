From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:51 +0200
Subject: [PATCH 16/17] of: add vendor prefix for CIAA project
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-17-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

CIAA stands for Argentine Open Industrial Computer. The CIAA project
is an initiative sponsored by universities and private companies.
Its main goal is to promote local embedded systems development.

Among other devices, the project developed a NXP LPC4337-based
reference design.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d444757c4d9e..c2f0af7b276d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -46,6 +46,7 @@ chipone		ChipOne
 chipspark	ChipSPARK
 chrp	Common Hardware Reference Platform
 chunghwa	Chunghwa Picture Tubes Ltd.
+ciaa	Computadora Industrial Abierta Argentina
 cirrus	Cirrus Logic, Inc.
 cloudengines	Cloud Engines, Inc.
 cnm	Chips&Media, Inc.
-- 
1.8.0
