From: jdswensen.linuxdev@gmail.com (Jake Swensen)
Date: Thu, 19 Nov 2015 15:24:07 -0600
Subject: stm32: stm32f429-discovery: toolchain setup and image flashing
 questions
Message-ID: <CABuSPYZKSyqQ0g3nJCtri+GKGk1YhjyaLM6SdxG6_63kzevqXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to develop a Linux application on the STM32F429-Discovery board and
having some trouble booting after flashing the Linux image I've compiled.
I've been following the steps outlined at http://elinux.org/STM32, so my first
question would be is the information on this wiki still up to date? If not, can
anyone point me to a better source? Right now I'm using the bare-metal
toolchain,
u-boot, and the a fork of the mainline kernel hosted at
https://github.com/Varcain/linux_ARMv7M. I'm not concerned with busybox quite
yet.

I can successfully compile and flash u-boot (using the texane tools).
On reset, it drops me into the u-boot shell because it can't find the
kernel (expected). After flashing the dtb and xip to 0x08004000 and
0x08008000, u-boot doesn't display any standard boot messages at all.
Are these memory locations still correct, or am I missing something else?

Thanks,
Jake
