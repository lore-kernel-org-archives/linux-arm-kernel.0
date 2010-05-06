From: al@alarsen.net (Anders Larsen)
Date: Thu, 06 May 2010 10:36:58 +0200
Subject: [at91] Save power by disabling the processor clock when CPU is
	idle
In-Reply-To: <20100505202529.GB25037@pengutronix.de> (from
	u.kleine-koenig@pengutronix.de on Wed May  5 22:25:29 2010)
References: <20100505202529.GB25037@pengutronix.de>
Message-ID: <1273135018l.10732l.0l@i-dmzi_al.realan.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2010-05-05 22:25:29, Uwe Kleine-K?nig wrote:
> There is a kernel parameter (IIRC "nohlt") that should take care of
> this?!

I hadn't noticed that one (it's operating several layers above the piece
of code I modified).

So it seems we could do way with the #else clause completely (requiring
the user to set 'nohlt' when debugging with JTAG)?

Cheers
Anders
-- 
happy 'ptxdist' user
