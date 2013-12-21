From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Dec 2013 14:16:43 +0000
Subject: [rtc-linux] Re: Can someone Ack and queue a patch for RTC
 subsytem?
In-Reply-To: <8738lnl19p.fsf@natisbad.org>
References: <87siton6ke.fsf@natisbad.org>
 <20131219164624.GV2609@titan.lakedaemon.net>
 <20131219175738.1dad3ade@linux.lan.towertech.it>
 <8761qk32pj.fsf@natisbad.org>
 <20131220183050.GB31886@sirena.org.uk>
 <8738lnl19p.fsf@natisbad.org>
Message-ID: <20131221141643.GC30815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 09:23:46PM +0100, Arnaud Ebalard wrote:

> I do not even know to which specific component the irq line of the chip
> is connected. You can take a look at [1] to see what's on the PCB; if
> you have an idea about which one could be a good candidate (TPS65251?),
> I can try and check with an ohmmeter which pin is connected to confirm
> your guess. Then, I could look at the datasheet (if any) to see if it
> can relay the interrupt to the SoC (if the component is supported by
> Linux kernel).

That's a PMIC which is what I'd expect if it's able to wake the device -
if it's anything like the other TI PMICs it ought to be able to act as
an interrupt controller.
