From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 19 Dec 2014 16:17:29 -0500
Subject: kernel.org - master not booting on keystone  (ARM v7 Cortex A15
 SoC) EVMs
In-Reply-To: <549490D6.3090804@ti.com>
References: <549490D6.3090804@ti.com>
Message-ID: <549495E9.7090700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2014 03:55 PM, Murali Karicheri wrote:
> Hi,
>
> I have pulled the latest master from
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and
> tried booting on keystone k2hk and k2e EVM. The boot hangs with
> following log. Has anyone seen this? Keystone is an ARM v7 cortex A15
> SMP platform. I am assuming master branch is broken for ARM v7 and
> someone is working to address this. v3.18 booted up fine on my EVM.
>
> Any idea?
>
Just see below if I enable debug earlyprintk

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.18.0-11757-gd790be3 
(a0868495 at ares-ubuntu) (gcc version 4.7.3 20130226 (prerelease) 
(crosstool-NG linaro-1.13.1-4.7-2013.03-20130313 - Linaro GCC 2013.03) ) 
#1 SMP PREEMPT Fri Dec 19 15:53:47 EST 2014
[    0.000000] CPU: ARMv7 Processor [412fc0f4] revision 4 (ARMv7), 
cr=30c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction 
cache
[    0.000000] Machine model: Texas Instruments Keystone 2 Edison EVM
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Switching to high address space at 0x800000000
[    0.000000] WARNING: unsafe modification of in-place page tables - 
tainting kernel
[    0.000000] cma: Reserved 16 MiB at 0x000000085f000000
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc



-- 
Murali Karicheri
Linux Kernel, Texas Instruments
