From: joel@jms.id.au (Joel Stanley)
Date: Thu, 14 Apr 2016 19:17:41 +0930
Subject: [PATCH 1/9] doc/devicetree: Add Aspeed and Tyan to vendor-prefixes
In-Reply-To: <1460627269-21721-1-git-send-email-joel@jms.id.au>
References: <1460627269-21721-1-git-send-email-joel@jms.id.au>
Message-ID: <1460627269-21721-2-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ASPEED Technology Inc is a fabless IC-design company.  Their web site
is http://www.aspeedtech.com/.

Tyan is a manufactuer of server and workstation platforms.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 86740d4a270d..192843189ceb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -29,6 +29,7 @@ arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
 artesyn	Artesyn Embedded Technologies Inc.
 asahi-kasei	Asahi Kasei Corp.
+aspeed	ASPEED Technology Inc.
 atlas	Atlas Scientific LLC
 atmel	Atmel Corporation
 auo	AU Optronics Corporation
@@ -250,6 +251,7 @@ tplink	TP-LINK Technologies Co., Ltd.
 tronfy	Tronfy
 tronsmart	Tronsmart
 truly	Truly Semiconductors Limited
+tyan	Tyan Computer Corporation
 upisemi	uPI Semiconductor Corp.
 urt	United Radiant Technology Corporation
 usi	Universal Scientific Industrial Co., Ltd.
-- 
2.7.4
