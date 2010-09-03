From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Sep 2010 21:01:55 +0200
Subject: [PATCH 1/7] ARM: specify ZRELADDR for ARCH_TEGRA
In-Reply-To: <AANLkTi=7+TcOWu_62EWH6pwFUuizMT47tHJraaqzdJgp@mail.gmail.com>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTi=7+TcOWu_62EWH6pwFUuizMT47tHJraaqzdJgp@mail.gmail.com>
Message-ID: <20100903190155.GE17152@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Erik,

On Fri, Sep 03, 2010 at 10:46:43AM -0700, Erik Gilling wrote:
> Yeah I saw that and posted a patch on the 27th and sent a pull request
> to Linus on Wednesday.  Hopefully it will make rc4.
OK for me, I'll keep it in my queue and will drop it when Linus got
the change.  You didn't remove the line from
arch/arm/mach-tegra/Makefile.boot, though.

(hmm, I thought that patches that touch common files like
arch/arm/Kconfig should go via rmk?!)  (BTW, I think lines like
Change-Id: Ic28177a645e2d5bc53099c15dcd5b1ae7f3d5208 in the commit log
are OK in general if they help you in any way.  Maybe just prefix it
something unique, 'Android-Change-Id:'?)

Best regards
Uwe
 
> On Fri, Sep 3, 2010 at 2:56 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > This was missed in commit
> >
> > ? ? ? ?e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)
> >
> > Cc: linux-tegra at vger.kernel.org
> > Cc: Colin Cross <ccross@android.com>
> > Cc: Erik Gilling <konkers@android.com>
> > Cc: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ?| ? ?1 +
> > ?arch/arm/mach-tegra/Makefile.boot | ? ?1 -
> > ?2 files changed, 1 insertions(+), 1 deletions(-)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
