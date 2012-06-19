From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jun 2012 11:18:42 +0000
Subject: [PATCH] clk: SPEAr600: Fix ethernet clock name for DT based
 probing
In-Reply-To: <20120618172042.GA29647@gmail.com>
References: <1336725678-29327-1-git-send-email-sr@denx.de>
 <201206181109.15250.sr@denx.de> <20120618172042.GA29647@gmail.com>
Message-ID: <201206191118.42416.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 June 2012, Mike Turquette wrote:
> > Ping again (this is a real show-stopper for SPEAr600 in v3.5!).
> > 
> I've taken this into my clk-next branch already.  Sorry if I did not
> communicate that well enough.  I will request for clk-next to be
> included into linux-next later this week.  Hopefully this patch will
> start showing up in linux-next in a matter of days.
> 
> Let me know if there is anything else I can do.

It sounds to me that Stefan needs this in 3.5, while the clk-next
patches are destined for 3.6. Is that correct? If so, do you also
have a clk-fixes branch that is targetted at 3.5 regressions?

	Arnd
