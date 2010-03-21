From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 21 Mar 2010 21:43:36 +0100
Subject: bit errors on spitz
In-Reply-To: <1268384824.4963.35.camel@utx.utx.cz>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
	<4B98EF5D.5000609@warmcat.com>
	<1268322155.3990.114.camel@hammer.suse.cz>
	<4B995EE1.1050609@warmcat.com>
	<1268384824.4963.35.camel@utx.utx.cz>
Message-ID: <20100321204335.GM1933@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2010-03-12 10:07:04, Stanislav Brabec wrote:
> Andy Green wrote: 
> > On 03/11/10 15:42, Somebody in the thread at some point said:
> > > Andy Green wrote:
> > >
> > >> I saw very similar failures for a long time on our iMX31 based device.
> > >> Eventually I found a Freescale errata where the RAM inside the USB2
> > >> macrocell started to make single bit errors below 1.38V Vcore; ours was
> > >> 1.4V at that time but dipped on CPU load.
> > >
> > > Good tip. It seems that nobody ported driver for the voltage control
> > > chip ISL6271 from 2.4 kernel, and bootloader probably does not set
> > > correct values.

Are we sure about this one? If we have wrong voltages on various
parts, that kind-off explains it.

Would it be possible to measure (Voltmeter) difference between 2.4
kernel and 2.6 kernel?

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
