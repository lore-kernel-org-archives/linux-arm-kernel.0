From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 15 May 2013 16:29:03 -0700
Subject: u8500_defconfig: build failure in linux-next
Message-ID: <CAGa+x85Q8i9DCdTprbVX1opB9UdeD4uxAQpZ-CsqPYt86dLVFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee, Linus,

In building all the ARM defconfigs in linux-next, I noticed
u8500_defconfig not building:

  [...]
  CC      drivers/mfd/ab8500-debugfs.o
/work/kernel/next/drivers/mfd/ab8500-debugfs.c:95:23: fatal error:
mach/irqs.h: No such file or directory

Same build error on v3.10-rc1 and Linus' master branch (but is fine on v3.9)

Kevin
