From: tony@atomide.com (Tony Lindgren)
Date: Wed, 1 Jul 2015 23:10:12 -0700
Subject: [GIT PULL] omap generic wakeirq for v4.2 merge window
In-Reply-To: <7hh9pnmxry.fsf@deeprootsystems.com>
References: <20150616114645.GA4156@atomide.com>
 <20150629060409.GQ4156@atomide.com>
 <7hh9pnmxry.fsf@deeprootsystems.com>
Message-ID: <20150702061011.GX4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@kernel.org> [150701 13:26]:
> Tony Lindgren <tony@atomide.com> writes:
> >
> > This one is OK to merge now, both pm-wakeirq and tty-next
> > dependencies have been merged. This leaves the following
> > diffstat for thees changes:
> 
> OK, thanks.  I'm collecting a few remaining things for a "late" branch,
> but if I miss the merge window, I'll queue it up for -rc2.

OK thanks -rc cycle should be doable too as these fix issues with
interrupt re-entrancy that's possible if the wakeirq and the
device IO interrupt ever fire at the same time. So far have not
seen that though.. But that's mostly luck.

Regrads,

Tony
