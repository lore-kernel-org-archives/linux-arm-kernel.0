From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  3 May 2016 17:16:19 +0200
Subject: [PATCH 0/3] HSI: omap-ssi: regressions against yesterday's linux-next
Message-ID: <1462288586-584690-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

One patch you added yesterday unfortunately caused (at least) three
separate build problems with 32-bit ARM randconfig builds.

These three patches should make it all work again.

        Arnd
