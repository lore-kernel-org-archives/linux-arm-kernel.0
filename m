From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 23 Mar 2010 12:48:06 -0400 (EDT)
Subject: [PATCH] Kirkwood: Marvell GuruPlug support
In-Reply-To: <20100323132331.GT13429@chipmunk>
References: <1269250100-31824-1-git-send-email-gores@marvell.com>
	<i13k77-9sp.ln1@chipmunk.wormnet.eu>
	<1269348203.23313.198.camel@pe-dt434>
	<20100323132331.GT13429@chipmunk>
Message-ID: <alpine.LFD.2.00.1003231247350.31128@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Mar 2010, Alexander Clouter wrote:

> Hi,
> 
> * Siddarth Gore <gores@marvell.com> [2010-03-23 18:13:23+0530]:
> >
> > On Mon, 2010-03-22 at 05:05 -0700, Alexander Clouter wrote:
> >
> > > Any harm in merging this into the sheevaplug-setup code, like the openrd 
> > > code?
> > > 
> > > http://git.marvell.com/?p=orion.git;a=commit;h=b2fdb5660fccc060e47658baad8911a963397ced
> > 
> > No harm as such. but i think having separate setup files will be a
> > cleaner approach, instead of adding more if(machine_is_<>) statements.
> > 
> > Looks like openrd base/client are same boards with client having an
> > extra ethernet port. sheevaplug and guruplug are two different boards
> > (pcb's) having different gpio settings, peripherals, etc.
> > 
> Fair enough, I thought (with the exception of the shameful removal of 
> the onboard questionable serial/jtag) the boards were identical, just 
> with extra USB/NIC ports added.

"questionable" ??


Nicolas
