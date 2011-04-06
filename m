From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Apr 2011 17:44:23 -0400 (EDT)
Subject: [PATCH 1/2] ARM: Differentiate SheevaPlugs and DockStars on the
	basis of the memory size.
In-Reply-To: <1302122121-3652-2-git-send-email-holler@ahsoftware.de>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-2-git-send-email-holler@ahsoftware.de>
Message-ID: <alpine.LFD.2.00.1104061739100.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Apr 2011, Alexander Holler wrote:

> It is possible to differentiate a SheevaPlugs and DockStars on the basis
> of the memory size.
> 
> This makes it possible to unify both setup files.

No no no !!!  This is an abomination!

We are not going to reduce the amount of code under arch/arm/ with such 
fragile hacks.  This would create an even worse maintenance problem the 
day either of those devices is released with more RAM or whatever.


Nicolas
