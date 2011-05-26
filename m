From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 26 May 2011 09:06:55 -0600
Subject: [PATCH] ARM: Xilinx: Adding zynq platform support
In-Reply-To: <201105261559.41993.arnd@arndb.de>
References: <BANLkTiknh4nCviohecbcJEiWnSW-JdMxDw@mail.gmail.com>
	<alpine.LFD.2.00.1105241435550.3207@xanadu.home>
	<BANLkTi=hCpCbNzi1ZiKmGnbhmCG2Ce=EkA@mail.gmail.com>
	<201105261559.41993.arnd@arndb.de>
Message-ID: <20110526150655.GA26661@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 03:59:41PM +0200, Arnd Bergmann wrote:
> On Wednesday 25 May 2011, Grant Likely wrote:
> > 
> > As per discussion attached below.  Please pull this tree adding device
> > tree support to ARM, plus some other minor device tree changes.
> 
> Hi Grant and Linus,
> 
> There is also the new Xilinx zynq subarchitecture pending that depends
> on this, see below. Should we also include that right away, in order
> to have an example for other platforms? I think the code is clean
> enough and it would be good to have.
> 
> 	Arnd

Yes, this one definitely should (as we discussed in Budapest 2 weeks back).
Its been in linux-next for a while now too.

I've picked it up into devicetree/arm-next and run through a few build
tests before I push it out and update the pull request.

g.
