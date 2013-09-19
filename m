From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Sep 2013 14:19:26 +0200
Subject: [PATCH v2] ARM: new platform for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <523AE162.3040100@gmail.com>
References: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201309172245.25367.arnd@arndb.de>
 <20130918153424.GR24802@pengutronix.de>
 <201309191328.12717.arnd@arndb.de> <523AE162.3040100@gmail.com>
Message-ID: <20130919121926.GT24802@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Sep 19, 2013 at 01:34:58PM +0200, Sebastian Hesselbarth wrote:
> On 09/19/13 13:28, Arnd Bergmann wrote:
> >On Wednesday 18 September 2013, Uwe Kleine-K?nig wrote:
> >>On Tue, Sep 17, 2013 at 10:45:25PM +0200, Arnd Bergmann wrote:
> >>>On Tuesday 17 September 2013, Uwe Kleine-K?nig wrote:
> [...]
> >>>>+
> >>>>+void __init efm32_init_time(void)
> >>>>+{
> >>>>+	of_clk_init(NULL);
> >>>>+	clocksource_of_init();
> >>>>+}
> >>>
> >>>When Sebastian Hesselbarth's patches for of_clk_init() are merged,
> >>>this function can go away.
> >>Do you have a link?
> >
> >http://lmgtfy.com/?q=hesselbarth+of_clk_init ;-)
Hmm, I checked my linux-arm-kernel mailbox and failed to find the
series. Not reproducable though. Thanks.

> >
> >I've put Sebastian on Cc, I guess he can comment on the status of his
> >patches, so we can come up with a plan for dealing with the dependency
> >here.
> 
> Patch set has been sent yesterday, still waiting for ACK's.
> 
> Olof already mentioned to (a) take it in arm-soc early and (b) have
> a topic branch to depend on.
> 
> I guess I will prepare that topic branch and Olof can take it (or fall
> back to creating it on his own, if I fail to do it right).
I assume that means that it's expected to land in 3.13, and my efm32
patch at least not earlier. So please tell me when there is a branch to
depend on.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
