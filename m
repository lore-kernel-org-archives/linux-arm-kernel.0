From: kangshan0910@gmail.com (shan kang)
Date: Thu, 12 Jul 2012 10:14:35 +0800
Subject: ARM: why smp_mb() is not needed in the "__mutex_fastpath_lock" and
 "__mutex_fastpath_unlock" functions
Message-ID: <CAK2TD5ygowdy9t1TpfxAPbpvNQfMnMB-3Zp8TKMsTYtBZdGW=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
   I wonder why smp_mb() is not needed in the "__mutex_fastpath_lock"
and "__mutex_fastpath_unlock" functions which are located in the
"arch/arm/include/asm/mutex.h"?
   I think "dmb" instruction is necessary there.
