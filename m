From: jj@chaosbits.net (Jesper Juhl)
Date: Thu, 16 Jun 2011 23:51:38 +0200 (CEST)
Subject: [PATCH][Trivial] ARM: remove duplicate include from
	arch/arm/mach-dove/common.c
In-Reply-To: <20110526144804.GA31651@lunn.ch>
References: <alpine.LNX.2.00.1105261130190.17400@swampdragon.chaosbits.net>
	<20110526144804.GA31651@lunn.ch>
Message-ID: <alpine.LNX.2.00.1106162348320.8140@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 May 2011, Andrew Lunn wrote:

> Jesper Juhl pointed out there is a redundant include of
> linux/serial_8250.h. However it turns out both are redundant.
> This patch removes them both.
> 
> Only compile tested.
> 
> Reported-by:  Jesper Juhl <jj@chaosbits.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Seems you are right.

Reviewed-by: Jesper Juhl <jj@chaosbits.net>

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
