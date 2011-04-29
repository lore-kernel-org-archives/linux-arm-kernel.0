From: vikram186@gmail.com (Vikram Narayanan)
Date: Fri, 29 Apr 2011 20:37:40 +0530
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
In-Reply-To: <20110429143435.GU5126@n2100.arm.linux.org.uk>
References: <20110426203756.GD17290@n2100.arm.linux.org.uk>
	<BANLkTi=Y0CdRt1ktCs7NwG4pLqWeZeLQPg@mail.gmail.com>
	<alpine.LFD.2.02.1104271015000.3323@ionos>
	<BANLkTi=WRw9pphieBAnDRhSH_WSdyUdb_A@mail.gmail.com>
	<20110428133826.GM17290@n2100.arm.linux.org.uk>
	<BANLkTi=rG8y=OeF8jc8R48tMLm=eH1=gqQ@mail.gmail.com>
	<20110428142822.GN17290@n2100.arm.linux.org.uk>
	<BANLkTin9_=zwLCkqVcAfg-_pGTXk9GaZsg@mail.gmail.com>
	<20110428182420.GF17290@n2100.arm.linux.org.uk>
	<BANLkTi=Xb7c9GeNJ_Our0+euEmumk_0-OA@mail.gmail.com>
	<20110429143435.GU5126@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimcyE3tG+F1sDiNRr1rGkmdvp_4ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 8:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 29, 2011 at 07:56:56PM +0530, Vikram Narayanan wrote:
>> Can you also give some idea on how the system's RTC is hooked up with
>> the generic timekeeping code.
>> Is it hooked up in someway so that the walltime is calculated wrt the
>> initial value of the RTC?
>
> I'd like to pass you over to the RTC folk, but I don't think they're
> very active anymore.
>
> Suffice it to say that the RTC subsystem will set the system date/time
> on initialization from the RTC device if one is provided. ?All I can
> suggest is to look at drivers/rtc and include/linux/rtc.h for the
> details. ?The MAINTAINERS file should list who is responsible for RTC
> stuff as well as a mailing list for it.
>
Yes. Sure. I already have a driver in place for RTC, under /dev/rtc. I
will try to post my doubts in the RTC mailing lists.
Just noticed a folder clocksource under drivers.
Quite curious about what it is for?
Can you give some hints about it?

Thanks,
Vikram
