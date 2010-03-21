From: utx@penguin.cz (Stanislav Brabec)
Date: Sun, 21 Mar 2010 22:42:33 +0100
Subject: bit errors on spitz
In-Reply-To: <20100321204335.GM1933@elf.ucw.cz>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
	<4B98EF5D.5000609@warmcat.com>
	<1268322155.3990.114.camel@hammer.suse.cz>
	<4B995EE1.1050609@warmcat.com> <1268384824.4963.35.camel@utx.utx.cz>
	<20100321204335.GM1933@elf.ucw.cz>
Message-ID: <1269207753.13196.53.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek p??e v Ne 21. 03. 2010 v 21:43 +0100:
> On Fri 2010-03-12 10:07:04, Stanislav Brabec wrote:

> > > > Good tip. It seems that nobody ported driver for the voltage control
> > > > chip ISL6271 from 2.4 kernel, and bootloader probably does not set
> > > > correct values.
> 
> Are we sure about this one? If we have wrong voltages on various
> parts, that kind-off explains it.
> 
> Would it be possible to measure (Voltmeter) difference between 2.4
> kernel and 2.6 kernel?

If you are ready to run Zaurus in dismantled state, then yes. Measure on
the upper pin of the large coil in the center of the
http://www.penguin.cz/~utx/zaurus/pcbt_uc.jpg image or on the testpoint
nearby (probably to the right).

Alternatively, it is possible to write a driver. It is just one byte
write and one byte read via I2C.


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
