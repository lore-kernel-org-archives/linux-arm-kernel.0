From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 29 Mar 2010 20:27:36 +0200
Subject: bit errors on spitz
In-Reply-To: <1269207753.13196.53.camel@utx.utx.cz>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
	<4B98EF5D.5000609@warmcat.com>
	<1268322155.3990.114.camel@hammer.suse.cz>
	<4B995EE1.1050609@warmcat.com>
	<1268384824.4963.35.camel@utx.utx.cz>
	<20100321204335.GM1933@elf.ucw.cz>
	<1269207753.13196.53.camel@utx.utx.cz>
Message-ID: <20100329182736.GA1373@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2010-03-21 22:42:33, Stanislav Brabec wrote:
> Pavel Machek p??e v Ne 21. 03. 2010 v 21:43 +0100:
> > On Fri 2010-03-12 10:07:04, Stanislav Brabec wrote:
> 
> > > > > Good tip. It seems that nobody ported driver for the voltage control
> > > > > chip ISL6271 from 2.4 kernel, and bootloader probably does not set
> > > > > correct values.
> > 
> > Are we sure about this one? If we have wrong voltages on various
> > parts, that kind-off explains it.
> > 
> > Would it be possible to measure (Voltmeter) difference between 2.4
> > kernel and 2.6 kernel?
> 
> If you are ready to run Zaurus in dismantled state, then yes. Measure on
> the upper pin of the large coil in the center of the
> http://www.penguin.cz/~utx/zaurus/pcbt_uc.jpg image or on the testpoint
> nearby (probably to the right).

I'm not comfortable dismantling it :-(.

> Alternatively, it is possible to write a driver. It is just one byte
> write and one byte read via I2C.

Do you know what byte it is? That sounds easy enough...

But I have small problem now -- zaurus seems to work mostly fine
now. Does it depend on temperature, or what? Tried mtest,
nothing. Tried compiling kernel, ok... Will try few more times...

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
