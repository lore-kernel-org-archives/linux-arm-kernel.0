From: ext-phil.2.carmody@nokia.com (Phil Carmody)
Date: Fri, 17 Sep 2010 19:45:43 +0300
Subject: [linux-pm] [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <20100917153643.GC29739@sirena.org.uk>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk>
Message-ID: <20100917164543.GI20325@esdhcp04044.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/10 17:36 +0200, ext Mark Brown wrote:
> On Thu, Sep 16, 2010 at 08:29:33PM -0500, Nishanth Menon wrote:
> 
> > +struct opp_def {
> > +	unsigned long freq;
> > +	unsigned long u_volt;
> > +
> > +	bool enabled;
> > +};
> 
> It might be clearer to use some term other than enabled in the code -
> when reading I wasn't immediately sure if enabled meant that it was
> available to be selected or if it was the active operating point.  How
  ^^^^^^^^^
> about 'allowed' (though I'm not 100% happy with that)?

I think your query contains its own answer.

Phil
