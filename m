From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Apr 2012 10:00:53 +0200
Subject: [GIT PULL] i.MX cleanup patches for next
In-Reply-To: <CAOesGMhk9tGokNwy1kdFDB+G08OYEEq9Uf1Qu=K=T8ufick2ag@mail.gmail.com>
References: <20120411084403.GN3852@pengutronix.de>
 <CAOesGMhk9tGokNwy1kdFDB+G08OYEEq9Uf1Qu=K=T8ufick2ag@mail.gmail.com>
Message-ID: <20120416080053.GQ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 15, 2012 at 11:23:02AM -0700, Olof Johansson wrote:
> Hi,
> 
> 
> On Wed, Apr 11, 2012 at 1:44 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi Arnd, Olof,
> >
> > Please pull the following i.MX cleanup patches for next.
> >
> > Sascha
> >
> > The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> >
> > ?Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
> >
> > are available in the git repository at:
> >
> > ?git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-cleanup-20120411
> >
> > for you to fetch changes up to b0843e814737756a38003afe663a626653b66f58:
> >
> > ?efikamx: match machine descriptions with legacy (2012-04-02 11:20:38 +0200)
> >
> > ----------------------------------------------------------------
> > i.MX misc cleanups
> >
> > ----------------------------------------------------------------
> > Hector Oron (1):
> > ? ? ?efikamx: match machine descriptions with legacy
> >
> > Uwe Kleine-K?nig (1):
> > ? ? ?ARM: imx/mx21ads: remove unneeded cast
> 
> Same comment as on the other pull request regarding prefix on the efikamx patch.
> 
> Also, no need to date the tags -- the tag itself contains the date
> (Linus has been complaining to people who add redundant data to the
> tag contents when they send tags to him).

Ok, won't do this in future. I just thought it might be a good idea,
because otherwise I end up with the same tag names in the next pull
request.

> 
> Branch contents otherwise looks OK, so respin and send a fresh pull
> request and we'll merge it in.

Here it is:

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/arm-imx-cleanup

for you to fetch changes up to 33076883bc45bfdd5fa5c9bff7f012a460719aba:

  ARM: i.MX: efikamx: match machine descriptions with legacy (2012-04-16 09:54:50 +0200)

----------------------------------------------------------------
ARM: i.MX: misc board cleanups

----------------------------------------------------------------
Hector Oron (1):
      ARM: i.MX: efikamx: match machine descriptions with legacy

Uwe Kleine-K?nig (1):
      ARM: imx/mx21ads: remove unneeded cast

 arch/arm/mach-imx/mach-mx21ads.c      |    3 +--
 arch/arm/mach-imx/mach-mx51_efikamx.c |    3 +--
 arch/arm/mach-imx/mach-mx51_efikasb.c |    2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
