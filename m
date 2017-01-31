From: mzoran@crowfest.net (Michael Zoran)
Date: Tue, 31 Jan 2017 13:10:23 -0800
Subject: [PATCH] MAINTAINERS: Update for the current location of the
 bcm2835 tree.
In-Reply-To: <7f2dfd64-0054-4b1f-fc13-a4d1912c05db@gmail.com>
References: <20170131194801.13049-1-eric@anholt.net>
 <1485894779.25562.1.camel@crowfest.net>
 <7f2dfd64-0054-4b1f-fc13-a4d1912c05db@gmail.com>
Message-ID: <1485897023.25562.3.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-01-31 at 12:55 -0800, Florian Fainelli wrote:
> On 01/31/2017 12:32 PM, Michael Zoran wrote:
> > On Tue, 2017-01-31 at 11:48 -0800, Eric Anholt wrote:
> > > I've been maintaining the bcm2835 branches here for a year or so.
> > > 
> > > Signed-off-by: Eric Anholt <eric@anholt.net>
> > > ---
> > > ?MAINTAINERS | 2 +-
> > > ?1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 844835563ef8..64b281a7ff09 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2624,7 +2624,7 @@ M:	Lee Jones <lee@kernel.org>
> > > ?M:	Eric Anholt <eric@anholt.net>
> > > ?L:	linux-rpi-kernel at lists.infradead.org (moderated for
> > > non-
> > > subscribers)
> > > ?L:	linux-arm-kernel at lists.infradead.org (moderated for
> > > non-
> > > subscribers)
> > > -T:	git
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
> > > +T:	git git://github.com/anholt/linux
> > > ?S:	Maintained
> > > ?N:	bcm283[5-7x]
> > > ?F:	drivers/staging/vc04_services
> > 
> > Just to add two cents here, since this is sort of a open source
> > community driven thing, I think there should be multiple
> > maintainers in
> > case of a disagreement.??2 is good, 3 is better so that it's
> > impossible
> > to have a split disagreement and the third person can break the
> > tie.
> 
> You may want to look at the file, and not the diff, which is already
> listing 3 people.
> 

I know the file still has 3 people.  Eric was just asking in another e-
mail about changing the maintainers.

> > 
> > Github is cool as the e-mail based system is really, really
> > bad.??But
> > if it is on github, I think it should have a neutral name not a
> > person's name and allow multiple people to merge in pulls.
> > 
> > Unless of course, Eric wants to take 100% control of this whole
> > thing.
> > 
> 
> Really not clear what point you are trying to make here, other than
> you
> may not like how things are, but at some point, someone needs to
> merge
> patches somewhere, in a repository that's convenient, only to have
> them
> pulled by whoever is next up in the food chain. Where the code is
> really
> does not matter much because: git is distributed, patches can be
> collected from mailing-list archives.

I'm not 100% sure myself what the point is myself actually.:) 

But there is also no reason some inclined person couldn't flip things
around and make the linux root a topic branch in itself and merge it
into their own "version" of the kernel.  Then try to get the various
linux distributions to include that kernel as on option.  

That is what was essentially done with the Raspberry PI kernel to begin
with.  I'm not saying that's a better system or that I personally would
attempt to do that, just it's a is the picture right side up or upside
down thing.  It's arbitrary and just a matter of perspective.
