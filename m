From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 1 Apr 2013 17:14:50 +0000
Subject: [PATCH 1/2] ARM: tegra: move <mach/powergate.h> to
 <linux/tegra-powergate.h>
In-Reply-To: <5159B0FF.2010408@wwwdotorg.org>
References: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
 <201303301413.26549.arnd@arndb.de> <5159B0FF.2010408@wwwdotorg.org>
Message-ID: <201304011714.50703.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 April 2013, Stephen Warren wrote:
> On 03/30/2013 08:13 AM, Arnd Bergmann wrote:
> > On Saturday 30 March 2013, Stephen Warren wrote:

> > If not, we can probably take your patch for now, if you remove it
> > again for 3.11.
> 
> There are at least a couple of different things in this file:
> 
> a) The reset API, which definitely should be converted to the new reset
> API. I can't make any promises about which kernel release that will
> happen in, but it's definitely something we know we have to do.
> 
> b) Power-gating. This should probably be converted to use the
> powerdomains code. I believe Joseph Lo is aware of this, but again I
> can't promise any specific time-scale at this time.
> 
> So is this still OK, without any promises of timescale?
> 

Yes, sounds good.

	Arnd
