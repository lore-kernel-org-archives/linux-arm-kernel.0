From: minggr@gmail.com (Lin Ming)
Date: Thu, 2 Aug 2012 11:03:31 +0800
Subject: How to debug hard lockup issue
Message-ID: <CAF1ivSY=HsqrRypru55cYMBoyY75umkwrjbz5U0F85nL5mh3tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

I encountered a hard lockup on a armv5 board with 2.6.32 kernel.
There is no any message output since it is hard lockup.

I tried watchdog, but watchdog can only reset the board. I still can't
get any info.

The hard lockup is possibly because kernel blocked/looped with
interrupts disabled.

Is there any non-maskable interrupt I can use to dump the kernel stack?
Or any other hint?

Thanks,
Lin Ming
