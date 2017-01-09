From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 9 Jan 2017 09:19:59 -0800
Subject: [PATCH 0/3] watchdog: imx2: handle WMCR only being available on
 i.MX35 and later
In-Reply-To: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170109171959.GA7274@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 10:50:36AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this is my approach to fix the issue reported by Vladimir Zapolskiy.
> 
So ...

Unfortunately, I don't see any convergence on this issue. My take is that,
given the lack of convergence, it can't be that severe since no one feels
that it is important enough to get it fixed one way or the other to budge
from your positions.

I had the other patch in my watchdog-next branch. I'll drop it, and wait for
the two of you to agree to something. You can either agree to that something,
or try to convince Wim to accept one or the other patch set. For my part, I'll
only accept a patch or patch series which has a Signed-off: and/or Reviewed-by:
from both of you.

Maybe you can get together into a room and agree not to leave it until white
smoke comes out of the chimney. Just an idea.

Thanks,
Guenter
