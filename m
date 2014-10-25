From: wangnan0@huawei.com (Wang Nan)
Date: Sat, 25 Oct 2014 14:51:03 +0800
Subject: [PATCH v7 0/2] ARM: kprobes: enable OPTPROBES for ARM 32.
Message-ID: <1414219865-35988-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the 7th version of ARM KPROBEOPT patch series.  This patch
series is depend on previous patch series I have posted: 'ARM: kprobes:
introduces instruction checker.'.

Previous discussions can be found:

https://lkml.org/lkml/2014/10/22/254
https://lkml.org/lkml/2014/8/27/255
https://lkml.org/lkml/2014/8/12/12
https://lkml.org/lkml/2014/8/8/992
https://lkml.org/lkml/2014/8/8/5
https://lkml.org/lkml/2014/8/5/63

The main content of this patch series is identical to patch 6/7 and 7/7
in v6. I post a v7 series because Masami Hiramatsu suggests me to make
the ARM OPTPROBES and the checker mechanism two sepreted series.

Wang Nan (2):
  kprobes: copy ainsn after alloc aggr kprobe
  ARM: kprobes: enable OPTPROBES for ARM 32

 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/kprobes.h    |  26 ++++
 arch/arm/kernel/Makefile          |   3 +-
 arch/arm/kernel/kprobes-opt-arm.c | 285 ++++++++++++++++++++++++++++++++++++++
 kernel/kprobes.c                  |   6 +
 5 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/kernel/kprobes-opt-arm.c

-- 
1.8.4
