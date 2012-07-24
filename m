From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 16:23:01 +0000
Subject: [PATCH RESEND v5 0/4] atmel-mci device tree support
In-Reply-To: <1343136606-8874-1-git-send-email-ludovic.desroches@atmel.com>
References: <1343136606-8874-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <201207241623.01588.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 July 2012, ludovic.desroches at atmel.com wrote:
> I resend this set of patches because patches 2, 3 and 4 were acked by
> Jean-Christophe. Patch 1 was also acked by Jean-Christophe excepted for
> cd-inverted property since it was redundant with gpio bindings.
> 
> I thought we were agree to go ahead since it was a common binding already
> documented and it will concern all drivers.

I just looked at the patches for the first time, but it looks all great, so 

Acked-by: Arnd Bergmann <arnd@arndb.de>

> Chris are you agree to take patch 1/4? Others patches may go to at91 tree,
> isn't it?
> By the way, I have updated documentation in patch 1/4 in the same way as you
> did with the patch 'mmc: dt: Deduplicate binding docs by referencing mmc.txt'.
> I didn't remove common properties from slot part because I think it is not
> obvious to use these properties into the slot node.

If you want to take it all through the mmc tree, that's also fine with me.

	Arnd
