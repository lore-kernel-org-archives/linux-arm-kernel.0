From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 21 Nov 2014 14:35:49 +0800
Subject: [PATCH v10 0/2] ARM: kprobes: enable OPTPROBES for ARM32
Message-ID: <1416551751-50846-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the tenth (and final I hope) version of OPTPROBES for ARM32.

Previous discussion can be found:

https://lkml.org/lkml/2014/11/19/31
https://lkml.org/lkml/2014/11/18/41
https://lkml.org/lkml/2014/10/25/48
https://lkml.org/lkml/2014/10/22/254
https://lkml.org/lkml/2014/8/27/255
https://lkml.org/lkml/2014/8/12/12
https://lkml.org/lkml/2014/8/8/992
https://lkml.org/lkml/2014/8/8/5
https://lkml.org/lkml/2014/8/5/63

There is no code change in this patch series, only commit message
cleanup: move version information after '---' in patch 2.

Masami Hiramatsu (1):
  kprobes: Pass the original kprobe for preparing optimized kprobe

Wang Nan (1):
  ARM: kprobes: enable OPTPROBES for ARM 32

 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/kprobes.h    |  26 ++++
 arch/arm/kernel/Makefile          |   3 +-
 arch/arm/kernel/kprobes-opt-arm.c | 290 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/kprobes/opt.c     |   3 +-
 include/linux/kprobes.h           |   3 +-
 kernel/kprobes.c                  |   4 +-
 7 files changed, 325 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/kernel/kprobes-opt-arm.c

-- 
1.8.4
