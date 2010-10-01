From: san.mlists@gmail.com (Santhosh N)
Date: Fri, 1 Oct 2010 16:03:25 +0530
Subject: PXA270 linux-2.6.35.7 boot hang
Message-ID: <AANLkTim4HqQkT0uZTpsGCsFqObVA+v+Q7wHekGp5V+f3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am porting the latest linux kernel 2.6.35.7 on our PXA270 board. The
kernel starts booting and stops at:
Uncompressing Linux... done, booting the kernel.

I can run the linux kernel 2.6.26 on the same board without any
issues. I am passing the boot args as:
bootargs=console=ttyS2,460800 rw root=1f02

The STUART is used as the debug serial port. I had to change the
uart_base to STUART in arch/arm/mach-pxa/include/mach/uncompress.h to
get  "Uncompressing Linux... done, booting the kernel.".

I have set also set CONFIG_SERIAL_PXA_CONSOLE=y.

Can anyone tell if I am missing something?

Warm regards,
Santhosh N
