From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 9 Oct 2014 21:52:00 -0700
Subject: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80; clean
 up chip identification
In-Reply-To: <1412041673.9388.75.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714795.3040.45.camel@decadent.org.uk>
 <20140928220300.GB3248@norris-Latitude-E6410>
 <1412041673.9388.75.camel@decadent.org.uk>
Message-ID: <20141010045200.GC22169@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 02:47:53AM +0100, Ben Hutchings wrote:
> On Sun, 2014-09-28 at 15:03 -0700, Brian Norris wrote:
> > On Sun, Sep 14, 2014 at 06:13:15PM +0100, Ben Hutchings wrote:
> > > Note that these patch are:
> > > - Based on your 'testing' branch
> > 
> > Which testing branch? These two are the only official
> > repos for MTD:
> > 
> >     git git://git.infradead.org/linux-mtd.git
> >     git git://git.infradead.org/l2-mtd.git
> 
> You had a testing branch in
> git://git.infradead.org/users/norris/linux-mtd.git, and that included
> commit af249c3a0ca8 ('mtd: spi-nor: remove duplicated w25q128 entry')
> which this patch series depended on.

That repository is very much unofficial. I have a MAINTAINERS patch
queued up to add git://git.infradead.org/l2-mtd.git (our -next repo) to
reduce future confusion.

Regards,
Brian
