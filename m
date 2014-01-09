From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 9 Jan 2014 12:40:43 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140108184021.GW31886@sirena.org.uk>
References: <1389201013-23794-1-git-send-email-broonie@kernel.org>
 <20140108183006.GC9724@e102568-lin.cambridge.arm.com>
 <20140108184021.GW31886@sirena.org.uk>
Message-ID: <20140109124042.GA6089@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 06:40:21PM +0000, Mark Brown wrote:
> On Wed, Jan 08, 2014 at 06:30:06PM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Jan 08, 2014 at 05:10:10PM +0000, Mark Brown wrote:
> 
> > > +#include <linux/slab.h>
> 
> > Nitpick, <linux/slab.h> does not belong in this patch. There are other
> > includes that should be moved to the respective patch (percpu.h ?) where
> > they are actually used.
> 
> I can move this one but honestly I'm having an extremely difficult time
> summoning up the enthusiasm for looking for others and moving them - the
> practical impact will not be substantial.

Ok, it is your call and I understand I am being pedantic but from a logical
patch split perspective that's not correct and honestly it should take no more
than few minutes to move the includes where they actually belong.

Lorenzo
