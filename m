From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 11 Jul 2013 09:46:53 +0200
Subject: [PATCH v2 1/6] clk: samsung: move common plls registration into
 separate function
In-Reply-To: <CAKew6eUPBUZj4TuhNAjp6NitFUaeFBZscr_jqU3Y_wLi1m7Ekg@mail.gmail.com>
References: <201307100057.06061.heiko@sntech.de>
 <201307100057.48265.heiko@sntech.de>
 <CAKew6eUPBUZj4TuhNAjp6NitFUaeFBZscr_jqU3Y_wLi1m7Ekg@mail.gmail.com>
Message-ID: <1874409.iWz7oWBuYA@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 10 of July 2013 22:29:13 Yadwinder Singh Brar wrote:
> Hi Heiko,
> 
> On Wed, Jul 10, 2013 at 4:27 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > All Samsung PLLs use similar code to register the clocks and clkdev
> > lookups. Therefore move these into a separate function to reduce code
> > duplication.
> > 
> > Suggested-by: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> 
> I have posted patch for adding common pll registration function
> which some how missed to get merged. I hope will get merged after rc1.
> Please give a look at that :
> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg19543.html

Yeah, I was going to post a link to it, but I couldn't find it on any mailing 
list archive. I think we should go with the way of registration introduced by 
Yadwinder.

Best regards,
Tomasz
