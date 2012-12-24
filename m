From: engr.nawaz1991@gmail.com (Muhammad Nawaz)
Date: Tue, 25 Dec 2012 03:40:17 +0500 (PKT)
Subject: Compilaion Error in uClinux
In-Reply-To: <17223460.185.1356388476745.JavaMail."Mohammad
 Nawaz"@MohammadNawaz>
Message-ID: <50d8d9d6.e25eb40a.3a2f.1f30@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone 
I am new to embedded Linux. 
I've downloaded uClinux version by Emcraft from GitHub-Emcraft (https://github.com/EmcraftSystems) and tried to compile it using sourcery code bench (http://www.codesourcery.com/sgpp/lite/arm/portal/package6493/public/arm-none-eabi/arm-2010q1-188-arm-none-eabi-i686-pc-linux-gnu.tar.bz2) 
I configured it for cortex-m3 (LPC18xx). 
During compilation, it generated the following error... 
---------------------------------- 
HOSTCC usr/gen_init_cpio 
GEN usr/initramfs_data.cpio 
AS usr/initramfs_data.o 
LD usr/built-in.o 
CC arch/arm/kernel/compat.o 
CC arch/arm/kernel/elf.o 
AS arch/arm/kernel/entry-common.o 
arch/arm/kernel/entry-common.S: Assembler messages: 
arch/arm/kernel/entry-common.S:131: Error: invalid immediate for address calculation (value = 0x00000004) 
arch/arm/kernel/entry-common.S:150: Error: invalid immediate for address calculation (value = 0x00000004) 
make[1]: *** [arch/arm/kernel/entry-common.o] Error 1 
make: *** [arch/arm/kernel] Error 2 
----------------------------------- 
Please help me to sort it out. 
I'll be very thankful to you. 

Regards.. 
Muhammad Nawaz 
http://pk.linkedin.com/in/nawaz1991/ 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121225/e0a023bc/attachment-0001.html>
