From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Jul 2014 11:01:52 +0200
Subject: ASoC: samsung: MACH_SMDK6450
In-Reply-To: <CAOesGMjdVrOfyrF6X3KoMQxBBYzNZskUsaMaHH653LJgwqpA+Q@mail.gmail.com>
References: <1404287238.12021.7.camel@x220>
 <023d01cf9720$5ed32fc0$1c798f40$@samsung.com>
 <CAOesGMjdVrOfyrF6X3KoMQxBBYzNZskUsaMaHH653LJgwqpA+Q@mail.gmail.com>
Message-ID: <4203198.qV4EZfpui2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 July 2014 20:39:41 Olof Johansson wrote:
> On Thu, Jul 3, 2014 at 5:39 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Mark Brown wrote:
> >>
> >> On Thu, Jul 03, 2014 at 07:37:07AM +0900, Kukjin Kim wrote:
> >> > On 07/02/14 18:23, Mark Brown wrote:
> >>
> >> > >This also wasn't sent to me for review, please always send patches to
> >> > >maintainers.
> >>
> >> > Mark, I always send patches to regarding maintainers and in this case the
> >> > patch missed the change. I'm resending new patch and if any problems, please
> >> > let me know. Just note, I just wanted to check whether there is no problem
> >> > with other maintainers' tree early in -next tree.
> >>
> >> It looks like you've sent it to broonie at linaro.org not broonie at kernel.org
> >> which is listed in MAINTAINERS and what I use for e-mail - upstream mail
> >> that goes to my work address often just gets dropped on the floor (and
> >> generally ends up at the bottom of my queue to look at) since it ends up
> >> in a completely different place to my personal mail.
> >
> > Mark, oh, I see. But I checked your e-mail address from recent your sign-off
> > in git commit so, just thought it should be fine.
> >
> > I will use kernel.org for your e-mail address next time 
> 
> Mark is the _only_ linux developer in the world who will give you crap
> for sending him patches to the very same email that he signs off all
> his work with.
> 
> I really wish Linaro would just let him sign off with his
> long-standing kernel.org email address instead so the rest of us
> wouldn't have to keep track of this. 

FWIW David Miller has a similar policy: he only applies networking
patches that are sent to the netdev mailing list. This seems like
a good idea in general (to ensure they are getting exposed to the
public).

Mark, any chance we could convince to pick up patches from
alsa-devel in the future even if they are sent to the wrong
personal email account of yours? I would assume that would only
require a small change in your filter rules, not a change in your
workflow.

	Arnd
