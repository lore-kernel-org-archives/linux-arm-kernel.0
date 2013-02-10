From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 10 Feb 2013 16:05:20 -0500
Subject: [GIT PULL  3/4] ARM: mvebu: boards for v3.9
In-Reply-To: <20130210003113.GB16278@quad.lixom.net>
References: <pull-1359733919-342140> <1359733919.c3D01c3.22262@triton>
 <20130205071010.GD13049@quad.lixom.net>
 <20130205112104.GP14746@titan.lakedaemon.net>
 <20130205182333.GA21051@quad.lixom.net>
 <20130205183050.GZ14746@titan.lakedaemon.net>
 <20130205232604.GB14851@quad.lixom.net>
 <20130206132015.GB14746@titan.lakedaemon.net>
 <20130210003113.GB16278@quad.lixom.net>
Message-ID: <20130210210520.GI14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 09, 2013 at 04:31:13PM -0800, Olof Johansson wrote:
> On Wed, Feb 06, 2013 at 08:20:15AM -0500, Jason Cooper wrote:
> > On Tue, Feb 05, 2013 at 03:26:04PM -0800, Olof Johansson wrote:
> > > What makes sense is to hold off the patches that adds dts entries and
> > > removes the platform device registrations to the next release to avoid
> > > this dependency.
> > 
> > Hmm, this makes life a *lot* simpler, but it also really slows things
> > down.  I'll go ahead and do this from now on.
> > 
> > Would you like me to redo /boards and /dt in light of this, or just do
> > it from here forward?
> 
> It doesn't necessarily slow things down -- it increases latency though. I.e.
> you'll end up building a pipeline over time.

Yes, that's not a problem.

> I agree that we're not entirely clear on this, and we're also going back and
> forth a bit on how much of this we push back on and not. I don't think we've
> found quite a good balance of this yet. Hm.

Well, it appears to me the crux of it is: How hard is it to merge and
re-merge branches with dependencies on driver trees?  If it's a PITA,
then let's do as you've suggested.  A sane, but slower process will
incur fewer mistakes.

Also, we can sit down an go ever this (with a few beers) at ELC.  ;-)

I'll redo as you've suggested for this go-around, and we can hash it out
in a few weeks.

thx,

Jason.
