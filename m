From: khilman@ti.com (Kevin Hilman)
Date: Thu, 12 Jul 2012 10:50:13 -0700
Subject: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
In-Reply-To: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com> (Paul
 Walmsley's message of "Thu, 12 Jul 2012 04:54:49 -0600 (MDT)")
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
Message-ID: <87394wg97u.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Commit 3dd50d0545bd5a8ad83d4339f07935cd3e883271 ("Merge tag 
> 'omap-cleanup-for-v3.6' into tmp-merge") inadvertently caused a 
> clockdomain to be registered twice on OMAP3 boards.  This causes warnings 
> on boot, wild pointer dereferences, and PM regressions.  Fix the double 
> registration and add some clockdomain code to prevent this from happening 
> again.
>
> Reported-by: Joe Woodward <jw@terrafix.co.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Acked-by: Kevin Hilman <khilman@ti.com>

This fixes the problem I reported here:

     http://marc.info/?l=linux-omap&m=134203768012711&w=2

Thanks,

Kevin
