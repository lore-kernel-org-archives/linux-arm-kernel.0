From: jkosina@suse.cz (Jiri Kosina)
Date: Mon, 20 Jun 2011 10:40:58 +0200 (CEST)
Subject: [PATCH][Trivial] ARM: remove duplicate include from
	arch/arm/mach-dove/common.c
In-Reply-To: <alpine.LFD.2.00.1106192318310.2142@xanadu.home>
References: <alpine.LNX.2.00.1105261130190.17400@swampdragon.chaosbits.net>
	<20110526144804.GA31651@lunn.ch>
	<alpine.LNX.2.00.1106162348320.8140@swampdragon.chaosbits.net>
	<alpine.LFD.2.00.1106192318310.2142@xanadu.home>
Message-ID: <alpine.LNX.2.00.1106201040480.11049@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 19 Jun 2011, Nicolas Pitre wrote:

> > > Jesper Juhl pointed out there is a redundant include of
> > > linux/serial_8250.h. However it turns out both are redundant.
> > > This patch removes them both.
> > > 
> > > Only compile tested.
> > > 
> > > Reported-by:  Jesper Juhl <jj@chaosbits.net>
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > Seems you are right.
> > 
> > Reviewed-by: Jesper Juhl <jj@chaosbits.net>
> 
> Could this patch be sent to RMK's patch system if no one else 
> picks it up please?

I have picked it up last week.

-- 
Jiri Kosina
SUSE Labs
