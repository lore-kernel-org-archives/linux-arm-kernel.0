From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Oct 2014 15:12:44 -0700
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141027230138.GB7805@drone.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
Message-ID: <20141028221243.GU2542@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [141027 16:03]:
> Hi,
> 
> On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> > +
> > +	if (!of_have_populated_dt())
> > +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> > +
> 
> Maybe use WARN so that the warning is more verbose and kernel gets tainted?

Well I was hoping to avoid annoying people with the trace.
But can do that if people prefer that, what do others think?

Regards,

Tony
