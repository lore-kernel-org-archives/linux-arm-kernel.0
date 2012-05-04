From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 14:27:31 +0000
Subject: [PATCH v2 0/9] support dt for mmp2
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201205041427.31333.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Haojian Zhuang wrote:
> v2:
> 1. remove MACH_MMP_LEGACY & MACH_MMP2_LEGACY
> 2. use irq.c to replace irq-pxa168.c & irq-mmp2.c
> 3. Avoid to use CONFIG_OF in entry-macro.S
> 

Looks all good to me now,

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
