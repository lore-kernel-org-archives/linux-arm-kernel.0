From: david.wu@rock-chips.com (David Wu)
Date: Wed,  9 Aug 2017 20:10:30 +0800
Subject: [PATCH v4 05/12] Documentation: net: phy: Add phy-is-internal binding
In-Reply-To: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
References: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1502280630-2254-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for internal phy. A boolean property
indicates that a internal phy will be used.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 Documentation/devicetree/bindings/net/phy.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
index b558576..942c892 100644
--- a/Documentation/devicetree/bindings/net/phy.txt
+++ b/Documentation/devicetree/bindings/net/phy.txt
@@ -52,6 +52,9 @@ Optional Properties:
   Mark the corresponding energy efficient ethernet mode as broken and
   request the ethernet to stop advertising it.
 
+- phy-is-internal: If set, indicates that phy will connect to the MAC as a
+  internal phy.
+
 Example:
 
 ethernet-phy at 0 {
-- 
1.9.1
