From: pistol@cs.duke.edu (Valentin Pistol)
Date: Fri, 14 Sep 2012 04:08:24 -0400
Subject: ARM: hw_breakpoint: silent EPERM when setting ARM_DSCR_MDBGEN on
 ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <20120913214102.GB11399@mudshark.cambridge.arm.com>
References: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
 <20120913214102.GB11399@mudshark.cambridge.arm.com>
Message-ID: <CAPfQmKJ2CJ4=yguXNa+acng0++sLYoJ1oRiEbqRjYha_N3rU6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Valentin,

Hi Will,

> You might want to configure your mail client to wrap lines at 76-80 columns
> in order to make your mails more readable.

Thanks for the good suggestion.

>> Summary:
>> Kernel is compiled with CONFIG_HAVE_HW_BREAKPOINT but after boot the DSCR register does not have monitor mode enabled which is required for debug register use.
>
> That means that hardware breakpoints are unusable on your platform, likely
> because it has been locked down in the hardware (there is a signal that
> can be tied off to prevent monitor mode debug).

Is there a reliable way to determine that they are locked down?
Any particular register/bit I can check to confirm?
If they're really locked down I think getting a development board is
likely the only way to have full support (considering a PandaBoard).

> Completely untested patch below, please let me know how you get on...

Looks good, I'll give it a try.

Thanks a lot for your help!
Valentin
