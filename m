From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Oct 2015 16:33:55 +0000
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <3533886.bbrHZIjT1f@amdc1976>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1> <3533886.bbrHZIjT1f@amdc1976>
Message-ID: <20151028163355.GH4058@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2015, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, October 28, 2015 08:24:46 AM Lee Jones wrote:
> > On Tue, 2015-10-27 at 18:15 +0000, Lee Jones wrote:
> > > On Tue, 27 Oct 2015, Sebastian Reichel wrote:
> > > > On Tue, Oct 27, 2015 at 03:42:37PM +0000, Lee Jones wrote:
> > > > > Since eafbaac ("MAINTAINERS: Add "R:" designated-reviewers tag") we
> > > > > have been able to tag specific people as Reviewers.  These are key
> > > > > individuals who are tasked with or volunteer to review code submitted
> > > > > to a subsystem or specific file.  However, according to MAINTAINERS
> > > > > we have 1046 Maintainers and only a mere 22 Reviewers.  I believe
> > > > > these numbers to be incorrect, as many of these Maintainers are in
> > > > > fact Reviewers.
> > 
> > Most entries in MAINTAINERS seem to be vanity entries than actual
> > active participants.  A person typically writes a driver, adds a
> > MAINTAINER entry, then forgets about it and/or the hardware becomes
> > outdated.
> > 
> > This I agree with.
> > 
> > On Wed, 28 Oct 2015, Krzysztof Kozlowski wrote:
> > > 2015-10-28 3:44 GMT+09:00 Joe Perches <joe@perches.com>:
> > > > On Tue, 2015-10-27 at 18:15 +0000, Lee Jones wrote:
> > > > > On Tue, 27 Oct 2015, Sebastian Reichel wrote:> >
> > > > > > I think you should CC the people, which are changed from "M:" to
> > > > > > "R:", though.
> > > > >
> > > > > Yes, makes sense.
> > > > >
> > > > > I'd like to collect some Maintainer Acks first though.
> > > >
> > > > I think people from organizations like Samsung are actual
> > > > maintainers not reviewers.
> > 
> > So this all hinges on how we are describing Maintainers and Reviewers.
> > 
> > My personal definition (until convinced otherwise) is that Reviewers
> > care about their particular subsystem and/or files.  They conduct code
> > reviews to ensure nothing gets broken and the code base stays in best
> > possible state of worthiness.  On the other hand Maintainers usually
> > conduct themselves as Reviewers but also have 'maintainership' duties
> > as well; such as applying patches, *maintaining*, testing, rebasing,
> > etc, an upstream branch and ultimately sending pull-requests to higher
> > level Maintainers i.e. Linus.  Maintainers also have the ultimate say
> > (unless over-ruled by Linus etc) over what gets applied.
> > 
> > > > Their drivers are not thrown over a wall and forgotten.
> > > 
> > > At least for Samsung Multifunction PMIC drivers (and some of Maxim
> > > MUICs and PMICs) these are actively used by us in existing and new
> > > products. They are also continuously extended and actually maintained.
> > > This means that it is not only about review of new patches but also
> > > about caring that nothing will become broken.
> > 
> > Exactly.  This what I expect of any good code Reviewer.
> > 
> > > I would prefer to leave the "SAMSUNG MULTIFUNCTION PMIC DEVICE
> > > DRIVERS" entry as is - maintainers.
> > 
> > But you aren't maintaining the driver i.e. you don't collect patches
> > and *maintain* them on an upstream branch.  Granted some of you guys
> > are doing a great job of maintaining branches on your downstream or
> > BSP kernels, but conduct a Reviewer type role for upstream.
> > 
> > You guys are pushing back like this is some kind of demotion.  That's
> > not the case at all.  All it does is better describe the (very worthy)
> > function you *actually* provide.
> 
> It is actually a demotion from my POV:
> 
> * "Reviewer" doesn't accurately describe the job of doing all the needed
>   testing, bug-fixing and additional contributions that is often done by
>   people without their own branches.
> 
> * You don't know internal policies of all companies involved in Linux
>   Kernel development.  "Maintainer" is a well known term and sometimes
>   person's job status or "key performance indicators" may depend on it.

I'm going to drop the patch I think.

Despite it being the correct thing to do from a logical perspective, I
see it having too many personal, emotional and social issues/
repercussions.

Let's let sleeping dogs lie.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
