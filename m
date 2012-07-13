From: omycle@gmail.com (Li Haifeng)
Date: Fri, 13 Jul 2012 15:02:35 +0800
Subject: ARM: why smp_mb() is not needed in the "__mutex_fastpath_lock"
 and "__mutex_fastpath_unlock" functions
In-Reply-To: <CAK2TD5ygowdy9t1TpfxAPbpvNQfMnMB-3Zp8TKMsTYtBZdGW=Q@mail.gmail.com>
References: <CAK2TD5ygowdy9t1TpfxAPbpvNQfMnMB-3Zp8TKMsTYtBZdGW=Q@mail.gmail.com>
Message-ID: <CAFNq8R6dNb0BrDVZScJ8s=P3B-OMgtr8tUdy8XqQcCAeUWuH+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shan,

2012/7/12 shan kang <kangshan0910@gmail.com>:
> Hello,
>    I wonder why smp_mb() is not needed in the "__mutex_fastpath_lock"
> and "__mutex_fastpath_unlock" functions which are located in the
> "arch/arm/include/asm/mutex.h"?
>    I think "dmb" instruction is necessary there.

Why necessary? Could you explain more detailed?

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
