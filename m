From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  4 Oct 2013 12:56:39 +0200
Subject: [PATCH] MAINTAINERS: mv643xx_eth: take over maintainership from
 Lennart
Message-ID: <1380884199-25025-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lennart says: "I haven't been able to spend time on mv643xx_eth for a
while now, so if you want to take over maintainership, I'd be fine with
that."

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
TBH, I have no clue about netdev internals, yet. But if David and Jason
Cooper promise to have one eye each on the first Acks, I am willing to
take over maintainership.

Cc: David Miller <davem@davemloft.net>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e61c2e8..72057a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5306,7 +5306,7 @@ S:	Orphan
 F:	drivers/net/wireless/libertas/
 
 MARVELL MV643XX ETHERNET DRIVER
-M:	Lennert Buytenhek <buytenh@wantstofly.org>
+M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	netdev at vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/marvell/mv643xx_eth.*
-- 
1.7.10.4
