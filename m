From: kangshan0910@gmail.com (shan kang)
Date: Wed, 11 Jul 2012 16:14:39 +0800
Subject: About smp_mb in the mutex locks
Message-ID: <CAK2TD5ykR-xDRmLRiM_k=edSGm52HzLdX+KkGUVzbFW5Tscq-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
   I wonder why smp_mb() is not needed in the "__mutex_fastpath_lock" and
"__mutex_fastpath_unlock" functions which are located in the
"arch/arm/include/asm/mutex.h"?
   I think "dmb" instruction is necessary there.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120711/10906e25/attachment-0001.html>
