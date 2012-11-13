From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 13 Nov 2012 11:53:43 +0400
Subject: [PATCH v2 12/17] ARM: clps711x: autcpu12: Special driver for
 handling NAND memory is removed
In-Reply-To: <201211121617.41304.arnd@arndb.de>
References: <1352545136-29089-1-git-send-email-shc_work@mail.ru>
 <1352545136-29089-13-git-send-email-shc_work@mail.ru>
 <201211121617.41304.arnd@arndb.de>
Message-ID: <20121113115343.6c3db91def746b8c73802082@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Nov 2012 16:17:41 +0000
Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 10 November 2012, Alexander Shiyan wrote:
> > This patch provide migration to using "gpio-nand" and "basic-mmio-gpio"
> > drivers instead of using special driver for handling NAND memory.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Applying this patch fails to build because it requires "GENERIC_GPIO" to be
> enabled in Kconfig, which is not enabled here.
All necessary symbols for build is present in patch:
[PATCH v2 16/17] ARM: clps711x: Update defconfig due latest changes and
 new kernel symbols

-- 
Alexander Shiyan <shc_work@mail.ru>
