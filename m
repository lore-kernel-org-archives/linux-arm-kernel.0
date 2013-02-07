From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 7 Feb 2013 16:35:51 +0200
Subject: [PATCH] Fix ARM build error on 3.8-rc6
Message-ID: <1360247752-25681-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Building ARM kernel with allyesconfig fails currently on 3.8-rc6. Here's a
patch to fix this issue.

Arnd asked me to send this directly to you, as there are no other pending
arm-soc fixes.

 Tomi

Tomi Valkeinen (1):
  omapdrm: fix the dependency to omapdss

 drivers/staging/omapdrm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.10.4
