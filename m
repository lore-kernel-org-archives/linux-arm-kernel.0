From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 17 Jan 2017 23:54:57 +0100
Subject: [PATCH 1/3] Documentation: devicetree: Add Kingnovel vendor prefix
In-Reply-To: <20170117030611.23827-2-afaerber@suse.de>
References: <20170117030611.23827-2-afaerber@suse.de>
Message-ID: <20170117225459.4438-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Their domain name is spelled kingnoval, but textually Kingnovel.

Cc: ada at kingnoval.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 14fd1c24e1f0..b38301c4f3f0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -156,6 +156,7 @@ karo	Ka-Ro electronics GmbH
 keithkoep	Keith & Koep GmbH
 keymile	Keymile GmbH
 kinetic Kinetic Technologies
+kingnovel	Kingnovel Technology Co., Ltd.
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
 lacie	LaCie
-- 
2.10.2
