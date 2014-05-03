From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:35:12 +0200
Subject: [PATCH v2 3/5] ARM: Kirkwood: Document net[25x]big compatible strings
In-Reply-To: <1399142114-24257-1-git-send-email-andrew@lunn.ch>
References: <1399142114-24257-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399142114-24257-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the compatible strings for net2big and net5big to the list of
kirkwood boards.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/arm/marvell,kirkwood.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
index 925ecbf6e7b7..01683a1564bb 100644
--- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
@@ -42,6 +42,9 @@ board. Currently known boards are:
 "lacie,cloudbox"
 "lacie,inetspace_v2"
 "lacie,laplug"
+"lacie,net2big"
+"lacie,net5big"
+"lacie,netxbig"
 "lacie,netspace_lite_v2"
 "lacie,netspace_max_v2"
 "lacie,netspace_mini_v2"
-- 
2.0.0.rc0
