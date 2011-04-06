From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Apr 2011 17:02:53 -0400 (EDT)
Subject: [PATCH 2/2] ARM: Remove machine type dockstar (use sheevaplug
	instead)
In-Reply-To: <1302122121-3652-3-git-send-email-holler@ahsoftware.de>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-3-git-send-email-holler@ahsoftware.de>
Message-ID: <alpine.LFD.2.00.1104061700440.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Apr 2011, Alexander Holler wrote:

> There is no need to have a different machine type for Seagate DockStars.
> Remove it.
> 
> Be aware, this patch requires a change in the bootloader to feed the
> same machine type to the kernel as used for Marvell SheevaPlugs.

This is therefore not a good idea to do this.

If the SheevaPlug setup code can be reused as is for DockStars, then it 
is best to simply add an additional machine record along with the 
SheevaPlug one.


Nicolas
