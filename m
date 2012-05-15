From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 15 May 2012 14:37:03 -0400 (EDT)
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board with
 device tree
In-Reply-To: <201205151423.31044.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56A998C6C@IL-MB01.marvell.com>
 <20120515131935.GI6820@lunn.ch> <201205151423.31044.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1205151431240.1640@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2012, Arnd Bergmann wrote:

> I agree that "armada" is a rather bad choice, because chips under that name
> include both the pxa/mmp family and the orion/kirkwood/mv78xx0/dove family
> which AFAICT don't have much in common at all besides the CPU cores.

Oh, right.  I remember now. Scrap my earlier suggestion then.  Armada 
came out of Marvell's marketing dept, not the engineering dept.

Maybe we should just go with mach-mrvl_ebu and eventually move orion5x, 
kirkwood, dove, and friends in there.  Why "ebu"? Because that's the 
internal Marvell name for the division that produced all those SOCs, 
hence their similarities, whereas PXA/MMP SOCs came from Intel 
initially.


Nicolas
