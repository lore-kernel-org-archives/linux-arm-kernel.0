From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Sep 2012 11:04:39 +0100
Subject: ARM: hw_breakpoint: silent EPERM when setting ARM_DSCR_MDBGEN on
 ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <CAPfQmKJ2CJ4=yguXNa+acng0++sLYoJ1oRiEbqRjYha_N3rU6Q@mail.gmail.com>
References: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
 <20120913214102.GB11399@mudshark.cambridge.arm.com>
 <CAPfQmKJ2CJ4=yguXNa+acng0++sLYoJ1oRiEbqRjYha_N3rU6Q@mail.gmail.com>
Message-ID: <20120918100438.GC32204@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 09:08:24AM +0100, Valentin Pistol wrote:
> Is there a reliable way to determine that they are locked down?
> Any particular register/bit I can check to confirm?

You can take a look at the DBGAUTHSTATUS register and try to determine the
signal values for SPNIDEN, DBGEN and NIDEN.

> > Completely untested patch below, please let me know how you get on...
> 
> Looks good, I'll give it a try.

Great. Let me know if it helps and, if so, I'll merge it.

Will
