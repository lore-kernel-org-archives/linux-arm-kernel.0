From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Feb 2016 07:08:06 -0800
Subject: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
In-Reply-To: <20160211115128.GF13270@sirena.org.uk>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-4-git-send-email-tony@atomide.com>
 <20160211115128.GF13270@sirena.org.uk>
Message-ID: <20160211150806.GS19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@kernel.org> [160211 03:52]:
> On Wed, Feb 10, 2016 at 03:02:46PM -0800, Tony Lindgren wrote:
> 
> > Mark, I'd like to merge this along with other related fixes via
> > the ARM SoC tree if no objections, please review and ack if this
> > look OK to you.
> 
> Why, I'm not seeing any dependencies here?  I'd also expect to be seeing
> an awful lot more changes like this, this shouldn't be an OMAP thing -
> do we need to fix the core API and then roll out the transition in a
> different way?

Please feel free to pick up this one if you have other fixes
lined up, nothing stopping that.

There will be likely more fixes like this to make drivers follow
the PM runtime API documentation. These were just the initial
ones that were obvious.

Regards,

Tony
