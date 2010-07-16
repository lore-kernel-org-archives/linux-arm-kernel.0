From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Jul 2010 10:41:51 +0100
Subject: LMB build failure in -next
Message-ID: <20100716094151.GI9082@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In -next the patch 'ARM: initial LMB trial' is causing build failures:

  CHECK   arch/arm/kernel/setup.c
arch/arm/kernel/setup.c:30:11: error: unable to open 'linux/lmb.h'

for me.  Looks like the generic header got missed from the commit or
there's some other tree that also needs to be in -next?
