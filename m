From: alior@marvell.com (Lior Amsalem)
Date: Tue, 15 May 2012 15:29:12 +0300
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <4FB23C17.8040107@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB23C17.8040107@codethink.co.uk>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56A998C3B@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ben Dooks [mailto:ben.dooks at codethink.co.uk]
> Sent: Tuesday, May 15, 2012 2:21 PM
> To: Thomas Petazzoni
> Cc: Arnd Bergmann; Olof Johansson; Lior Amsalem; Andrew Lunn; Jason
> Cooper; Nicolas Pitre; Maen Suleiman; Ben Dooks; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] arm: Add basic support for new Marvell Armada SoC
> family
> 
> On 15/05/12 09:54, Thomas Petazzoni wrote:
> > Arnd, Olof,
> >
> > You'll find in this patch set the initial support for a new family of
> > ARMv7-compatible Marvell SoCs, that we have choosen to support in the
> > arch/arm/mach-armada/ directory.
> 
> [snip]
> 
> Out of interest, what about the Marvell Sheeva-V7 core specific errata that
> the Marvell kernel has?
Work in progress. As well as SMP support.

> 
> --
> Ben Dooks				http://www.codethink.co.uk/
> Senior Engineer				Codethink - Providing Genius

Lior Amsalem
