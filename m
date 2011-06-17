From: jkosina@suse.cz (Jiri Kosina)
Date: Fri, 17 Jun 2011 12:01:55 +0200 (CEST)
Subject: [PATCH][Trivial] ARM: remove duplicate include from
	arch/arm/mach-dove/common.c
In-Reply-To: <alpine.LNX.2.00.1106162348320.8140@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1105261130190.17400@swampdragon.chaosbits.net>
	<20110526144804.GA31651@lunn.ch>
	<alpine.LNX.2.00.1106162348320.8140@swampdragon.chaosbits.net>
Message-ID: <alpine.LNX.2.00.1106171201210.22872@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jun 2011, Jesper Juhl wrote:

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

I don't seem to be able to find the patch anywhere during a quick search 
of the archives. Could you please bounce it to me (in case it hasn't been 
already applied elsewhere)?

Thanks,

-- 
Jiri Kosina
SUSE Labs
