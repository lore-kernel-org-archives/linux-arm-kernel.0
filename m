From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 27 Oct 2010 15:31:10 -0400 (EDT)
Subject: QNAP TS-209 broken by "orion/kirkwood: reset PCIe unit on boot"
In-Reply-To: <20101027144024.GC10830@jirafa.cyrius.com>
References: <20101019190533.GA11893@jirafa.cyrius.com>
	<alpine.LFD.2.00.1010191529100.2764@xanadu.home>
	<FCBE654890C0334289D0AD3AF4EF009FD18F0B415F@IL-MB01.marvell.com>
	<alpine.LFD.2.00.1010211608550.2764@xanadu.home>
	<20101025151210.GV16863@jirafa.cyrius.com>
	<20101027111656.GA11417@jirafa.cyrius.com>
	<alpine.LFD.2.00.1010270856370.27159@xanadu.home>
	<20101027144024.GC10830@jirafa.cyrius.com>
Message-ID: <alpine.LFD.2.00.1010271527260.29484@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Oct 2010, Martin Michlmayr wrote:

> * Nicolas Pitre <nico@fluxnic.net> [2010-10-27 08:57]:
> > > A Debian user has confirmed in the meantime that the patch helps on
> > > the TS-419P.
> > 
> > Helped what, exactly?
> 
> The SATA problems on TS-419P are gone, i.e. this confirms 2) of your
> "Can I have confirmation that 1) new breakages are gone, and 2) the
> device where this reset did fix problems are still OK with this
> change?"

OK.  I'd like to have confirmation that what remains of the workaround 
is enough to cover those machines where it is needed.  But given that 
most feedback I get so far is "I was never able to reproduce the issue 
myself in the first place" then I'll simply push this change as is.


Nicolas
