From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 29 May 2013 06:14:28 -0400
Subject: [PATCH] arm: kirkwood: convert NETGEAR ReadyNAS Duo v2 to use
 DT for the PCIe interface
In-Reply-To: <20130529094236.619bd698@skate>
References: <8738t6ycnm.fsf@natisbad.org> <20130529002053.4b8ceb86@skate>
 <20130528223817.GL31290@titan.lakedaemon.net>
 <20130529094236.619bd698@skate>
Message-ID: <20130529101428.GN31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 09:42:36AM +0200, Thomas Petazzoni wrote:
> On Tue, 28 May 2013 18:38:17 -0400, Jason Cooper wrote:
> 
> > > Could you check that you're running on top of the latest
> > > jcooper/mvebu/pcie branch? Thanks!
> > 
> > Actually, you want jcooper/mvebu/pcie_kirkwood.  I split out the
> > kirkwood driver so that if it causes a build breakage and gets dropped,
> > mvebu/pcie can still go in.
> 
> There's not really a "kirkwood" driver for PCIe. The pcie-kirkwood
> stuff is really all about adding the right Device Tree informations,
> and switching from a legacy-style probing to a DT-style probing.

Agreed.  Bad word choice on my part.  It was late/early, too much/too
little coffee. ;-)

You still need mvebu/pcie_kirkwood for:

  005625f pci: mvebu: enable driver usage on Kirkwood

thx,

Jason.
