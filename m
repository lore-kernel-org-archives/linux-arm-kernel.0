From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 19 Jun 2011 23:20:20 -0400 (EDT)
Subject: [PATCH][Trivial] ARM: remove duplicate include from
	arch/arm/mach-dove/common.c
In-Reply-To: <alpine.LNX.2.00.1106162348320.8140@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1105261130190.17400@swampdragon.chaosbits.net>
	<20110526144804.GA31651@lunn.ch>
	<alpine.LNX.2.00.1106162348320.8140@swampdragon.chaosbits.net>
Message-ID: <alpine.LFD.2.00.1106192318310.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jun 2011, Jesper Juhl wrote:

> On Thu, 26 May 2011, Andrew Lunn wrote:
> 
> > Jesper Juhl pointed out there is a redundant include of
> > linux/serial_8250.h. However it turns out both are redundant.
> > This patch removes them both.
> > 
> > Only compile tested.
> > 
> > Reported-by:  Jesper Juhl <jj@chaosbits.net>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Seems you are right.
> 
> Reviewed-by: Jesper Juhl <jj@chaosbits.net>

Could this patch be sent to RMK's patch system if no one else 
picks it up please?
Thanks.


Nicolas
