From: sophian.yoma@gmail.com (yoma sophian)
Date: Thu, 18 Aug 2016 01:26:14 +0800
Subject: how to enable suspend to ram for arm-64 bits
Message-ID: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
After I finish porting aarch64 linux kernel on my platform and enable
CONFIG_PM and CONFIG_SUSPEND,  I found there is no output when I cat
/sys/power/state.

After tracing kernel code, kernel/power/suspend.c, it seems we need to
create global suspend method table with suspend_set_ops then we can
get valid pm_states.
Is any dts or place like arm/match-xxx for registering global suspend method?

appreciate your kind help in advance,
