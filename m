From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 Dec 2009 13:16:00 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <4B39FB2C.4010608@warmcat.com>
References: <20091228190009.GB14799@sirena.org.uk> <4B3901E3.20004@warmcat.com>
	<20091228192244.GD14799@sirena.org.uk>
	<4B390AC3.2060702@warmcat.com>
	<20091228202123.GA16524@sirena.org.uk>
	<4B391941.6000906@warmcat.com>
	<20091228224435.GA23617@sirena.org.uk>
	<4B39D439.9070909@warmcat.com>
	<20091229123348.GB5784@opensource.wolfsonmicro.com>
	<4B39FB2C.4010608@warmcat.com>
Message-ID: <20091230131559.GA369@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 29, 2009 at 12:50:52PM +0000, Andy Green wrote:
> On 12/29/09 12:33, Somebody in the thread at some point said:

> >Compared to NAND removable media can be a win, yes, though with fast
> >JTAG having to rewrite the flash needn't be any slower so it's not quite
> >that clear cut.

> Right, but if you can eliminate JTAG in the flow, especially at the
> factory, that is a major simplification.

An awful lot of production setups are capable of handling JTAG already
so don't have much of an issue here.  Certainly as a developer my
preference here would be for fast JTAG over SD card - it's at least as
fast, there's only one system involved and it works just the same no
matter what the state of the system is.

> Again all I can say is it's specialized case.  For normal dev work
> SD is either painless or hugely advantageous.

Assuming the hardware can cope with it, and there's component cost,
board area and mechanical concerns to address before it gets designed
in.  There are a lot of systems where it would be useful but there's
drawbacks you have to bear in mind when pushing it.
