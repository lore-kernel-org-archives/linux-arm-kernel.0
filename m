From: nareshgbhat@gmail.com (Naresh Bhat)
Date: Mon, 19 Nov 2012 19:57:10 +0530
Subject: KEXEC on ARM cortex-a15
Message-ID: <CAJXQGfKpFfUwMeLGFAuTgQn5Yd2D9O271JM1VJ87Nio80tbwXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am trying to test KEXEC feature on Cortex-a15 architecture.

I am using Kernel.org v3.4 kernel, and a u-boot boot loader on
Daughterboard Site 1: V2P-CA15_A7 Cortex A15

My question is do I need to pass any ATAG related information from
u-boot to Kernel ?? If so what should I pass ??

Please,  help me to overcome from below error message.

Error Message:


I can see the below question on dmesg "No ATAGs ?"
...........
...............
CPU1: Unknown IPI message 0x1
Brought up 2 CPUs
SMP: Total of 2 processors activated (3981.31 BogoMIPS).
NET: Registered protocol family 16
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
Serial: AMBA PL011 UART driver
..........
...............


root at arm-cortex-a15:~#kexec -f /boot/uImage
--command-line="root=/dev/nfs rw ip=dhcp mmci.fmax=6000000 -serial
stdio console=ttyAMA0"
Cannot open /proc/atags: No such file orStarting new kernel
 directory
Bye!
Uncompressing Linux...

-- 
"For things to change, we must change"
-Naresh Bhat
