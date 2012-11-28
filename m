From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 28 Nov 2012 20:06:19 +0800
Subject: [arm-soc:testing/defconfig-warnings 5/7] warning: (LOCKDEP &&
 FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK) selects
 FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS ||
 M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN || MN10300) ||
 ARCH_WANT_FRAME_POINTERS || MCOUNT)
Message-ID: <50b5fe3b.sIbu7abk7YPCiGkp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git testing/defconfig-warnings
head:   cc1ff79c309266ebb0ce389078bd2d624dc297d8
commit: be4be8f338a20c61261ee4780b2298218cfed239 [5/7] HACK: kallsyms: make it possible to disable kallsyms
config: make ARCH=sparc allyesconfig

All warnings:

warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN || MN10300) || ARCH_WANT_FRAME_POINTERS || MCOUNT)
warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN || MN10300) || ARCH_WANT_FRAME_POINTERS || MCOUNT)
--
warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN || MN10300) || ARCH_WANT_FRAME_POINTERS || MCOUNT)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
