From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 11 Jul 2013 10:52:13 +0200
Subject: [PATCH v2 1/6] clk: samsung: move common plls registration into
 separate function
In-Reply-To: <1874409.iWz7oWBuYA@thinkpad>
References: <201307100057.06061.heiko@sntech.de>
 <CAKew6eUPBUZj4TuhNAjp6NitFUaeFBZscr_jqU3Y_wLi1m7Ekg@mail.gmail.com>
 <1874409.iWz7oWBuYA@thinkpad>
Message-ID: <201307111052.13618.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 11. Juli 2013, 09:46:53 schrieb Tomasz Figa:
> Hi,
> 
> On Wednesday 10 of July 2013 22:29:13 Yadwinder Singh Brar wrote:
> > Hi Heiko,
> > 
> > On Wed, Jul 10, 2013 at 4:27 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > > All Samsung PLLs use similar code to register the clocks and clkdev
> > > lookups. Therefore move these into a separate function to reduce code
> > > duplication.
> > > 
> > > Suggested-by: Russell King <linux@arm.linux.org.uk>
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > 
> > I have posted patch for adding common pll registration function
> > which some how missed to get merged. I hope will get merged after rc1.
> > Please give a look at that :
> > http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg19543.ht
> > ml
> 
> Yeah, I was going to post a link to it, but I couldn't find it on any
> mailing list archive. I think we should go with the way of registration
> introduced by Yadwinder.

the linked patch looks nice, thanks for the link. So I'll redo the plls 
against it in the next round.


Heiko
