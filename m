From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 Aug 2013 15:30:11 -0400
Subject: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
In-Reply-To: <20130806182201.GB2123@gmail.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806182201.GB2123@gmail.com>
Message-ID: <20130806193011.GA19280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 11:22:01AM -0700, Daniel Price wrote:
> On Thu, Aug 01, 2013 at 03:25:03PM +0200, Thomas Petazzoni wrote:
> > Hello,
> > 
> > This set of patches introduces Message Signaled Interrupt support in
> > the Marvell EBU PCIe driver. It has been successfully tested on the
> > Armada XP GP platform with an Intel e1000e PCIe network card that
> > supports MSI.
> 
> Thomas,
> 
> I tested this set of patches on a custom Marvell Armada XP 78260 based
> board.  It was connected to another system over PCIe, through a
> non-transparent bridge; MSI support was required.  We also tested a
> similar configuration using the Armada XP GP platform.  The patch seems
> to work for us.  Many thanks!

That's awesome!

> Tested-by: Daniel Price <daniel.price@gmail.com>

Thanks, I've added this to the patches.

thx,

Jason.
