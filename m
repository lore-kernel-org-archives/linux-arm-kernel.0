From: virupax.sadashivpetimath@stericsson.com (Virupax SADASHIVPETIMATH)
Date: Mon, 4 Jul 2011 15:17:02 +0200
Subject: Spurious wakeup calls on Offlined CPU
Message-ID: <A3217089E06965468FCEC60ADC3A8F925610CF39EF@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Catalin 

On the DB8500 platform, the cpu1 offline and online produces a lot of
Spurious wakeup calls on cpu1. 
Can you please let me know what can be the cause for these spurious
wakeup calls on cpu1.
GIC does not show any interrupts pending for CPU1.

echo 0 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu1/online
CPU1: 35 Spurious wakeup calls
CPU1: Booted secondary processor
Switched to NOHz mode on CPU #1

Thanks 
