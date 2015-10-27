From: joe@perches.com (Joe Perches)
Date: Tue, 27 Oct 2015 11:44:42 -0700
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <20151027181555.GE5828@x1>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
Message-ID: <1445971482.2757.27.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-10-27 at 18:15 +0000, Lee Jones wrote:
> On Tue, 27 Oct 2015, Sebastian Reichel wrote:
> > On Tue, Oct 27, 2015 at 03:42:37PM +0000, Lee Jones wrote:
> > > Since eafbaac ("MAINTAINERS: Add "R:" designated-reviewers tag") we
> > > have been able to tag specific people as Reviewers.  These are key
> > > individuals who are tasked with or volunteer to review code submitted
> > > to a subsystem or specific file.  However, according to MAINTAINERS
> > > we have 1046 Maintainers and only a mere 22 Reviewers.  I believe
> > > these numbers to be incorrect, as many of these Maintainers are in
> > > fact Reviewers.

Most entries in MAINTAINERS seem to be vanity entries than actual
active participants.  A person typically writes a driver, adds a
MAINTAINER entry, then forgets about it and/or the hardware becomes
outdated.

> > > I have taken the time to identify some of the Reviewers who pertain
> > > to subsystems which I look after, and have changed their status from
> > > Maintainer (collector of patches) to Reviewer (reviewer of code).
> > 
> > [for drivers/power/*]
> > Acked-By: Sebastian Reichel <sre@kernel.org>
> 
> Thanks.
> 
> > I think you should CC the people, which are changed from "M:" to
> > "R:", though.
> 
> Yes, makes sense.
> 
> I'd like to collect some Maintainer Acks first though.

I think people from organizations like Samsung are actual
maintainers not reviewers.

Their drivers are not thrown over a wall and forgotten.
