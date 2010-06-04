From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 4 Jun 2010 15:37:28 +0800
Subject: Is it possible to fix the warning when including wm97xx_batt.h?
Message-ID: <AANLkTikX80CrjDVsJfdthnwoPsnXz15mIrr69afZg3af@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Regard the annoying warnings below, is it currently possible not to include
wm97xx_batt.h and include wm97xx.h instead?

In file included from
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/palmte2.c:26:
/home/ycmiao/kernel/linux-2.6/include/linux/wm97xx_batt.h:6: warning:
#warning This file will be removed soon, use wm97xx.h instead!
  CC      arch/arm/mach-pxa/palmtc.o
  CC      kernel/sysctl.o
  CC      arch/arm/mach-pxa/palmt5.o
In file included from
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/palmt5.c:27:
/home/ycmiao/kernel/linux-2.6/include/linux/wm97xx_batt.h:6: warning:
#warning This file will be removed soon, use wm97xx.h instead!
  CC      arch/arm/mach-pxa/palmtx.o
In file included from
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/palmtx.c:28:
/home/ycmiao/kernel/linux-2.6/include/linux/wm97xx_batt.h:6: warning:
#warning This file will be removed soon, use wm97xx.h instead!
  CC      arch/arm/mach-pxa/palmz72.o
In file included from
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/palmz72.c:30:
/home/ycmiao/kernel/linux-2.6/include/linux/wm97xx_batt.h:6: warning:
#warning This file will be removed soon, use wm97xx.h instead!
  CC      kernel/sysctl_binary.o
  CC      arch/arm/mach-pxa/palmld.o
In file included from
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/palmld.c:25:
/home/ycmiao/kernel/linux-2.6/include/linux/wm97xx_batt.h:6: warning:
#warning This file will be removed soon, use wm97xx.h instead!
  CC      arch/arm/mach-pxa/palmtreo.o
  CC      kernel/capability.o
In file included from
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/palmtreo.c:26:
/home/ycmiao/kernel/linux-2.6/include/linux/wm97xx_batt.h:6: warning:
#warning This file will be removed soon, use wm97xx.h instead!
