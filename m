From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 10 Nov 2012 00:11:23 +0100
Subject: Test of arm_timer_rework
Message-ID: <87a9uqtlr8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

You asked board maintainers to test your tree in :
git://nv-tegra.nvidia.com/user/swarren/linux-2.6 arm_timer_rework
(top commit is 3bbbe63cb12f1f29f1eadc0b3b93516502562f0e)

I've just done so for mioa701 board, pxa based (mach-pxa).

Kernel timer does work, and RTC does work too, in both active usecase, and with
a suspend/resume cycle.

If you wish, feel free to add my :
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
