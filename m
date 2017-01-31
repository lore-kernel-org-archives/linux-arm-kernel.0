From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2017 20:44:51 +0000
Subject: [PATCH] MAINTAINERS: Update for the current location of the
 bcm2835 tree.
In-Reply-To: <1485894779.25562.1.camel@crowfest.net>
References: <20170131194801.13049-1-eric@anholt.net>
 <1485894779.25562.1.camel@crowfest.net>
Message-ID: <20170131204451.GD27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 12:32:59PM -0800, Michael Zoran wrote:
> On Tue, 2017-01-31 at 11:48 -0800, Eric Anholt wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 844835563ef8..64b281a7ff09 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2624,7 +2624,7 @@ M:	Lee Jones <lee@kernel.org>
> > ?M:	Eric Anholt <eric@anholt.net>
> > ?L:	linux-rpi-kernel at lists.infradead.org (moderated for non-
> > subscribers)
> > ?L:	linux-arm-kernel at lists.infradead.org (moderated for non-
> > subscribers)
> > -T:	git
> > git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
> > +T:	git git://github.com/anholt/linux
> > ?S:	Maintained
> > ?N:	bcm283[5-7x]
> > ?F:	drivers/staging/vc04_services
> 
> Just to add two cents here, since this is sort of a open source
> community driven thing, I think there should be multiple maintainers in
> case of a disagreement.  2 is good, 3 is better so that it's impossible
> to have a split disagreement and the third person can break the tie.
> 
> Github is cool as the e-mail based system is really, really bad.  But
> if it is on github, I think it should have a neutral name not a
> person's name and allow multiple people to merge in pulls. 

The email-based "system" is standard Linux policy for patch review,
which has been established as a way of minimising the effort otherwise
required by reviewers.

If folk want to deal with stuff "internally" on github off-list, that's
fine, but in order to get patches upstreamed, the patches still need to
be posted to a public Linux mailing list for review purposes.

You can't get away from the "e-mail based system".  Sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
