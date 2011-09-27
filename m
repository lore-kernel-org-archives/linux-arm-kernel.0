From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 27 Sep 2011 10:16:43 +0100
Subject: Porting linux to Stellaris Cortex-M3
In-Reply-To: <CAH8SYHDRT7OpLr0sx75rMyy4OV59JZGoRv_cr2+-+2yy3tfU9g@mail.gmail.com>
References: <CAH8SYHDRT7OpLr0sx75rMyy4OV59JZGoRv_cr2+-+2yy3tfU9g@mail.gmail.com>
Message-ID: <20110927091643.GD14237@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 09:19:39PM +0100, Fernando Endo wrote:
> I'm currently porting linux to a Stellaris board from TI.
> But I'm having some problems with the execution of the Busybox init program.
> 
> Some info:
> - the toolchain is CodeSourcery lite edition
> - I've followed the steps described by Catalin Marinas at
> http://www.linux-arm.org/LinuxKernel/LinuxM3
> - I'm using my own bootloader, based on the script at the site above
> and on informations found on linux/Documents
> - I've based the mach-stellaris implementation from realview and mps ones
> - the timer, irqs and uart seems to work fine
> - the system crashes after calling /init, which is linked with Busybox init
> - BUG: scheduling while atomic: init/1/0xffff000a

Did you get any backtrace?

-- 
Catalin
