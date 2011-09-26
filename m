From: fernando.endo@phiinnovations.com (Fernando Endo)
Date: Mon, 26 Sep 2011 17:19:39 -0300
Subject: Porting linux to Stellaris Cortex-M3
Message-ID: <CAH8SYHDRT7OpLr0sx75rMyy4OV59JZGoRv_cr2+-+2yy3tfU9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everybody,

I'm currently porting linux to a Stellaris board from TI.
But I'm having some problems with the execution of the Busybox init program.

Some info:
- the toolchain is CodeSourcery lite edition
- I've followed the steps described by Catalin Marinas at
http://www.linux-arm.org/LinuxKernel/LinuxM3
- I'm using my own bootloader, based on the script at the site above
and on informations found on linux/Documents
- I've based the mach-stellaris implementation from realview and mps ones
- the timer, irqs and uart seems to work fine
- the system crashes after calling /init, which is linked with Busybox init
- BUG: scheduling while atomic: init/1/0xffff000a

Any idea?

Best regards,
Fernando Akira Endo
