From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Mar 2013 22:58:31 +0000
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308174358.GD4094@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130308150655.2bad20ce@skate> <20130308174358.GD4094@obsidianresearch.com>
Message-ID: <201303082258.31445.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 March 2013, Jason Gunthorpe wrote:
> > At this point, I have absolutely no idea what direction to take to
> > bring this further. I'm basically in a dead-end.
> 
> I think Jason C. has said he is fine with bringing in the MBUS driver as
> is.
> 
> The PCI-E driver's DT binding looks great to me, I have no further
> comments at all, and I believe everyone else's comments related to DT
> are delt with as well.
> 
> The huge discussion about the SW PCI-E bridge seems to be concluded
> and everyone is agreeing on that point too.
> 
> Soo, I think you are not at all at a dead end, but nearly finished :)

I agree, I think the has been going really well and we are just fighting
over a few details here. I was giving you all a hard time about the PCIe
driver, but that was actually less about the binding than about the
question whether to emulate P2P bridges or not. I still don't think
it's a good solution, but that is because of the hardware shortcomings
and all the alternatives are worse.

In case of the MBUS driver, I don't think it's a hard problem at all
(compared to the complexity of the PCIe driver and binding), we just
have to agree to do the right thing here.

	Arnd
