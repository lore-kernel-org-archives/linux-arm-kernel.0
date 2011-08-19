From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 14:24:09 +0900
Subject: [GIT PULL] samsung: fixes for v3.1-rc1
In-Reply-To: <CAH9JG2Wf9UFZkqoZm=Wr-RAYPTA6inbBkcGQi5bR+7mr-Tk+Bg@mail.gmail.com>
References: <20110811065837.GA4989@july>
	<015001cc57f5$d7e847f0$87b8d7d0$%kim@samsung.com>
	<201108121758.01077.arnd.bergmann@linaro.org>
	<000601cc596e$0ba61490$22f23db0$%kim@samsung.com>
	<CAH9JG2Wf9UFZkqoZm=Wr-RAYPTA6inbBkcGQi5bR+7mr-Tk+Bg@mail.gmail.com>
Message-ID: <000d01cc5e30$3ac08b40$b041a1c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Sat, Aug 13, 2011 at 1:04 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Arnd Bergmann wrote:
> >>
> >> On Thursday 11 August 2011, Kukjin Kim wrote:
> >> > > ? Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)
> >> > >
> >> > > are available in the git repository at:
> >> > > ? git://git.infradead.org/users/kmpark/linux-2.6-samsung for-arnd
> >> > >
> >>
> >> > No, if above is required, I think, this should be handled from me not
> > you.
> >> >
> >> > Don't make a complete confusion between your board and Samsung
> > architecture
> >> > maintainer.
> >>
> >> I'll hold off on pulling this one then until I get another pull request
> >> from you.
> >>
> >> Looking at the contents of the branch, I noticed that it's not clear
why
> >> they are needed in 3.1. It would help me if you (whoever sends me the
bug
> >> fixes) can categorize them in the changelog:
> >>
> >> * Any bug fixes against old bugs should be marked 'Cc:
stable at kernel.org'
> >> so that they can get identified for backports.
> >>
> >> * Regressions against the 3.0 kernel should get marked as such.
> >>
> >> * Bug fixes against new code should also be identified as such.
> >>
> > OK, I see.
> >
> > As a note, I will send Samsung fixes in the beginning of next week.
> 
> Do you need more time?

I will send before Arnd's sending for -rc3..maybe late tonight (KST).
Now I need to sort out current samsung-fixes...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
