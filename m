From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 3 Jul 2018 16:31:09 +0200
Subject: [RFC PATCH 1/4] dts: misc: Add bindings documentation for
 bmc-misc-ctrl
In-Reply-To: <a1c3ecd4fed28e2b33c95a476452318dba58cd7e.camel@kernel.crashing.org>
References: <20180703070413.28756-1-andrew@aj.id.au>
 <20180703070413.28756-2-andrew@aj.id.au>
 <20180703075009.GA27649@kroah.com>
 <a1c3ecd4fed28e2b33c95a476452318dba58cd7e.camel@kernel.crashing.org>
Message-ID: <20180703143109.GB2043@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 12:16:49AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-03 at 09:50 +0200, Greg KH wrote:
> > On Tue, Jul 03, 2018 at 05:04:10PM +1000, Andrew Jeffery wrote:
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > 
> > I can't take patches without any changelog text at all :(
> 
> Greg (and replying to your other comments as well)...
> 
> This is an RFC series, it's not meant for you to take at this point,
> it's about discussing the overall approach to exposing BMC random
> "tunables" as explained in patch 0 of the series.
> 
> Yes the individual patches aren't yet at the level of polish for a
> formal submission, we (naively ?) thought that's what the whole RFC tag
> is about :-)

Oh come on, putting a basic "here is what this patch does" comment
should be part of every patch, otherwise what is there to comment on if
we don't know what is going on in the patch itself?

Anyway, I provided a bunch of feedback to the "real" patch in this
series...


greg k-h
