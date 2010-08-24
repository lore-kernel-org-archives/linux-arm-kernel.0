From: david.yangshuai@gmail.com (David Yang)
Date: Tue, 24 Aug 2010 17:20:42 +0800
Subject: How to define CLOCK_TICK_RATE in linux kernel 2.6.xx?
Message-ID: <AANLkTi=T5QP_MbUgh4EfLjtW_be49vw2eLgXNNUCiTb7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

We have recently started to port linux 2.6.33 to a arm machine which be
cortex-a9 mpcore, and we found that need define CLOCK_TICK_RATE
(arch/arm/mach_xxx/include/mach/timex.h) to a value.

Now our arm machine have two timer, first is external general timer
which clock is 66.666666MHz, second is cortex-a9's private timer which
clock is 400MHz or 800Hz.

If our linux system support smp, we should how define CLOCK_TICK_RATE?
If our linux system don't support smp, we should how define
CLOCK_TICK_RATE?

BTW, In kernel 2.6.x, CLOCK_TICK_RATE means ?
Thank for any help

David
