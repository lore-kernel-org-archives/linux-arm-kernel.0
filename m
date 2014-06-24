From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Tue, 24 Jun 2014 16:52:23 +0900
Subject: [PATCH v3 -next 0/9] CMA: generalize CMA reserved area
 management code
In-Reply-To: <20140618135144.297c785260f9e2aebead867c@linux-foundation.org>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <539EB4C7.3080106@samsung.com>
 <20140617012507.GA6825@js1304-P5Q-DELUXE>
 <20140618135144.297c785260f9e2aebead867c@linux-foundation.org>
Message-ID: <20140624075223.GE4836@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 01:51:44PM -0700, Andrew Morton wrote:
> On Tue, 17 Jun 2014 10:25:07 +0900 Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> 
> > > >v2:
> > > >   - Although this patchset looks very different with v1, the end result,
> > > >   that is, mm/cma.c is same with v1's one. So I carry Ack to patch 6-7.
> > > >
> > > >This patchset is based on linux-next 20140610.
> > > 
> > > Thanks for taking care of this. I will test it with my setup and if
> > > everything goes well, I will take it to my -next tree. If any branch
> > > is required for anyone to continue his works on top of those patches,
> > > let me know, I will also prepare it.
> > 
> > Hello,
> > 
> > I'm glad to hear that. :)
> > But, there is one concern. As you already know, I am preparing further
> > patches (Aggressively allocate the pages on CMA reserved memory). It
> > may be highly related to MM branch and also slightly depends on this CMA
> > changes. In this case, what is the best strategy to merge this
> > patchset? IMHO, Anrew's tree is more appropriate branch. If there is
> > no issue in this case, I am willing to develope further patches based
> > on your tree.
> 
> That's probably easier.  Marek, I'll merge these into -mm (and hence
> -next and git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git)
> and shall hold them pending you review/ack/test/etc, OK?

Hello, Marek.

Could you share your decision about this patchset?

Thanks.
