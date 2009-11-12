From: pieterg@gmx.com (pieterg)
Date: Thu, 12 Nov 2009 11:49:35 +0100
Subject: pxafb: RGBT555 support
In-Reply-To: <200911051727.03171.pieterg@gmx.com>
References: <200910291235.55826.pieterg@gmx.com>
	<f17812d70911040633k27863332seaf29184ff38e7e7@mail.gmail.com>
	<200911051727.03171.pieterg@gmx.com>
Message-ID: <200911121149.35771.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 November 2009 17:27:02 pieterg wrote:
> On Wednesday 04 November 2009 15:33:21 Eric Miao wrote:
> > >> Unfortunately, transparency is part of depth and it's really not
> > >> easy to distinguish between RGB565 and RGBT555 by depth and
> > >> bits_per_pixel only without introducing something else.
> > >
> > > So perhaps something like this (untested)?
> >
> > This looks good to me - please have this tested and I'll merge it
> > later if no other comments.
>
> Tested, and it works.
> Please use this version instead of the original one I posted, no matter
> how small it is, I still managed to get a typo in ;)

Just for my information (and as a reminder perhaps), is this patch going to 
make it?

Rgds, Pieter
