From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 04 Jul 2018 00:16:49 +1000
Subject: [RFC PATCH 1/4] dts: misc: Add bindings documentation for
 bmc-misc-ctrl
In-Reply-To: <20180703075009.GA27649@kroah.com>
References: <20180703070413.28756-1-andrew@aj.id.au>
 <20180703070413.28756-2-andrew@aj.id.au> <20180703075009.GA27649@kroah.com>
Message-ID: <a1c3ecd4fed28e2b33c95a476452318dba58cd7e.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-03 at 09:50 +0200, Greg KH wrote:
> On Tue, Jul 03, 2018 at 05:04:10PM +1000, Andrew Jeffery wrote:
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> 
> I can't take patches without any changelog text at all :(

Greg (and replying to your other comments as well)...

This is an RFC series, it's not meant for you to take at this point,
it's about discussing the overall approach to exposing BMC random
"tunables" as explained in patch 0 of the series.

Yes the individual patches aren't yet at the level of polish for a
formal submission, we (naively ?) thought that's what the whole RFC tag
is about :-)

Cheers,
Ben.
