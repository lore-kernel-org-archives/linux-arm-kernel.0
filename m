From: starnight@g.ncu.edu.tw (Jian-Hong Pan)
Date: Fri, 24 Aug 2018 01:15:43 +0800
Subject: [RFC 3/3 net] lorawan: List LORAWAN in menuconfig
In-Reply-To: <cover.1535039998.git.starnight@g.ncu.edu.tw>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
Message-ID: <cd021897a590ee57605a497b23e7ea9341889aef.1535039998.git.starnight@g.ncu.edu.tw>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

List LORAWAN in menuconfig and enable it to be built.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 net/Kconfig  | 1 +
 net/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/Kconfig b/net/Kconfig
index 053b36998c18..499c931ba0fa 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -224,6 +224,7 @@ source "net/6lowpan/Kconfig"
 source "net/ieee802154/Kconfig"
 source "net/mac802154/Kconfig"
 source "net/lora/Kconfig"
+source "net/maclorawan/Kconfig"
 source "net/sched/Kconfig"
 source "net/dcb/Kconfig"
 source "net/dns_resolver/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index e80b84313851..5341d0e23586 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_6LOWPAN)		+= 6lowpan/
 obj-$(CONFIG_IEEE802154)	+= ieee802154/
 obj-$(CONFIG_MAC802154)		+= mac802154/
 obj-$(CONFIG_LORA)		+= lora/
+obj-$(CONFIG_LORAWAN)		+= maclorawan/
 
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o
-- 
2.18.0
