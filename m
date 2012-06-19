From: sr@denx.de (Stefan Roese)
Date: Tue, 19 Jun 2012 13:34:00 +0200
Subject: [PATCH] clk: SPEAr600: Fix ethernet clock name for DT based
 probing
In-Reply-To: <201206191118.42416.arnd@arndb.de>
References: <1336725678-29327-1-git-send-email-sr@denx.de>
 <20120618172042.GA29647@gmail.com> <201206191118.42416.arnd@arndb.de>
Message-ID: <201206191334.00618.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 June 2012 13:18:42 Arnd Bergmann wrote:
> On Monday 18 June 2012, Mike Turquette wrote:
> > > Ping again (this is a real show-stopper for SPEAr600 in v3.5!).
> > 
> > I've taken this into my clk-next branch already.  Sorry if I did not
> > communicate that well enough.  I will request for clk-next to be
> > included into linux-next later this week.  Hopefully this patch will
> > start showing up in linux-next in a matter of days.
> > 
> > Let me know if there is anything else I can do.
> 
> It sounds to me that Stefan needs this in 3.5,

Yes. Its definitely a fix for 3.5.

> while the clk-next
> patches are destined for 3.6. Is that correct? If so, do you also
> have a clk-fixes branch that is targetted at 3.5 regressions?

Thanks,
Stefan
