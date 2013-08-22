From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 22 Aug 2013 19:38:15 +0530
Subject: Linking failure on linux-next with arm allyesconfig
Message-ID: <CAHbNUh2MXZhg7L8BN9ds17rmg8ueo6d8CJhRMgy6fK-xn7qRoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With ARCH=arm 'allyesconfig' on next-20130822, following linking error
is observed.

arch/arm/kernel/built-in.o: In function `ret_fast_syscall':
/home/tushar/work/lt_devel/staging-tree/linux-next/arch/arm/kernel/entry-common.S:42:
undefined reference to `user_enter'
arch/arm/kernel/built-in.o: In function `no_work_pending':
/home/tushar/work/lt_devel/staging-tree/linux-next/arch/arm/kernel/entry-common.S:77:
undefined reference to `user_enter'
arch/arm/kernel/built-in.o: In function `vector_swi':
/home/tushar/work/lt_devel/staging-tree/linux-next/arch/arm/kernel/entry-common.S:376:
undefined reference to `user_exit'
arch/arm/kernel/built-in.o: In function `__dabt_usr':
/home/tushar/work/lt_devel/staging-tree/linux-next/arch/arm/kernel/entry-armv.S:365:
undefined reference to `user_exit'
arch/arm/kernel/built-in.o: In function `__irq_usr':
/home/tushar/work/lt_devel/staging-tree/linux-next/arch/arm/kernel/entry-armv.S:375:
undefined reference to `user_exit'
arch/arm/kernel/built-in.o: In function `__und_usr':
/home/tushar/work/lt_devel/staging-tree/linux-next/arch/arm/kernel/entry-armv.S:388:
undefined reference to `user_exit'
arch/arm/kernel/built-in.o: In function `__pabt_usr':
/home/tushar/work/lt_devel/staging-tree/linux-next/arch/arm/kernel/entry-armv.S:662:
undefined reference to `user_exit'

-- 
Tushar Behera
