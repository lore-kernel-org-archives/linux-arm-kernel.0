From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Oct 2015 10:14:55 +0000
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <56309419.4060908@samsung.com>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1> <56309419.4060908@samsung.com>
Message-ID: <20151028101455.GQ5828@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2015, Krzysztof Kozlowski wrote:
> On 28.10.2015 17:24, Lee Jones wrote:
> > On Wed, 28 Oct 2015, Krzysztof Kozlowski wrote:
> >> 2015-10-28 3:44 GMT+09:00 Joe Perches <joe@perches.com>:
> >>> On Tue, 2015-10-27 at 18:15 +0000, Lee Jones wrote:
> >>>> On Tue, 27 Oct 2015, Sebastian Reichel wrote:> >
> >>>>> I think you should CC the people, which are changed from "M:"
> >>>>> to "R:", though.
> >>>> 
> >>>> Yes, makes sense.
> >>>> 
> >>>> I'd like to collect some Maintainer Acks first though.
> >>> 
> >>> I think people from organizations like Samsung are actual 
> >>> maintainers not reviewers.
> > 
> > So this all hinges on how we are describing Maintainers and
> > Reviewers.
> > 
> > My personal definition (until convinced otherwise) is that Reviewers 
> > care about their particular subsystem and/or files.  They conduct
> > code reviews to ensure nothing gets broken and the code base stays in
> > best possible state of worthiness.  On the other hand Maintainers
> > usually conduct themselves as Reviewers but also have
> > 'maintainership' duties as well; such as applying patches,
> > *maintaining*, testing, rebasing, etc, an upstream branch and
> > ultimately sending pull-requests to higher level Maintainers i.e.
> > Linus.  Maintainers also have the ultimate say (unless over-ruled by
> > Linus etc) over what gets applied.
> 
> Okay, sounds reasonable... so if a person performs reviews plus he does
> some of the other activities (not all) then who is he?

LT;DR: If someone doesn't *maintain* an upstream branch, they are not
an upstream Maintainer.

> For example reviewing

Depends on the type of engagement.  Anyone can review any patch
submitted to anywhere on the code-base.  This does not make them an
accepted Reviewer.  Here I'm saying that a Reviewer is a competent
engineer who has made a promise to dedicate time to review incoming
patches in order to ensure quality.

To emphasise a tagged Reviewer isn't just someone who reviews code
every now and again.  It's someone who cares and has a vested interest
in either a subsystem as a whole, or perhaps individual or a group of
drivers.  However, this person does not conduct upstream branch
*maintenance*.

> testing + fixing bugs + cleaning up (sending
> patches from time to time)?

This is a Submitter/Contributor.

When I said testing before, I meant the branch being maintained, not
the driver on it's own.  That should be tested by Submitters/
Contributors or Testers (who get to provide their Tested-by).

> Would that be sufficient requirement to call him maintainer of a driver?
> Or maybe all of these requirements must be met (including handling of
> patches and sending pull reqs)?

It's only really the handing of patches and the maintenance of an
upstream branch which differentiates a Reviewer from a Maintainer. 

> >>> Their drivers are not thrown over a wall and forgotten.
> >> 
> >> At least for Samsung Multifunction PMIC drivers (and some of Maxim 
> >> MUICs and PMICs) these are actively used by us in existing and new 
> >> products. They are also continuously extended and actually
> >> maintained. This means that it is not only about review of new
> >> patches but also about caring that nothing will become broken.
> > 
> > Exactly.  This what I expect of any good code Reviewer.
> > 
> >> I would prefer to leave the "SAMSUNG MULTIFUNCTION PMIC DEVICE 
> >> DRIVERS" entry as is - maintainers.
> > 
> > But you aren't maintaining the driver i.e. you don't collect patches 
> > and *maintain* them on an upstream branch.
> 
> Indeed, we don't. However are other non-reviewing activities sufficient?

The other non-reviewing activities you mentioned are that of the
Submitter/Contributor/Tester.  They still don't make someone a
Maintainer.

> > Granted some of you guys 
> > are doing a great job of maintaining branches on your downstream or 
> > BSP kernels, but conduct a Reviewer type role for upstream.
> 
> You mentioned also the "ultimate say over what gets applied" - which in
> this particular case is interesting to us because we have direct
> interest in these drivers being in a good shape and doing things we
> expect them to do. Like representing the interest of users.

Any Reviewers opinion will matter to someone who ultimately applies
the patches.  For instance, if you were to say to me "this change to
our MFD doesn't suit us because of X", I almost certainly won't apply
the patch.

> Of course one could say that every upstreaming person has such
> expectations... but some of the upstreamers just send a driver for one
> device. Or extend driver for one device. In this case this is a family
> of devices used on all of our Exynos SoC products and we care about all
> of them.

And being a nominated Reviewer mentioned in MAINTAINERS, that's
exactly what I'd expect.  If people fail to mean these requirement
they should be removed completely.

> > You guys are pushing back like this is some kind of demotion.
> > That's not the case at all.  All it does is better describe the (very
> > worthy) function you *actually* provide.
> 
> It is getting into dispute about entire change of yours... which is not
> what I want. I agree with your general idea but I was referring only to
> that particular case - the Samsung PMICs (and Maxim PMICs/MUICs which
> would fall into same category).

I hope that I've explained my view adequately above.  My view is also
carried out over the Samsung drivers.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
