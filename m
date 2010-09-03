From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Sep 2010 21:23:29 +0200
Subject: [PATCH 1/7] ARM: specify ZRELADDR for ARCH_TEGRA
In-Reply-To: <AANLkTin2fEj2kRRoE+RSpBovApMaCKTs+DVz9wvj7M3u@mail.gmail.com>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTi=7+TcOWu_62EWH6pwFUuizMT47tHJraaqzdJgp@mail.gmail.com>
	<20100903190155.GE17152@pengutronix.de>
	<AANLkTin2fEj2kRRoE+RSpBovApMaCKTs+DVz9wvj7M3u@mail.gmail.com>
Message-ID: <20100903192329.GB29821@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Sep 03, 2010 at 12:19:26PM -0700, Erik Gilling wrote:
> On Fri, Sep 3, 2010 at 12:01 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Sep 03, 2010 at 10:46:43AM -0700, Erik Gilling wrote:
> >> Yeah I saw that and posted a patch on the 27th and sent a pull request
> >> to Linus on Wednesday. ?Hopefully it will make rc4.
> > OK for me, I'll keep it in my queue and will drop it when Linus got
> > the change. ?You didn't remove the line from
> > arch/arm/mach-tegra/Makefile.boot, though.
> 
> I'll do that too.
Note that Linus don't like to pull branches that don't match the pull
request.  (This makes him feel pulling uncooked changes.)
If you do, you can add my Ack.

> > (hmm, I thought that patches that touch common files like
> > arch/arm/Kconfig should go via rmk?!)
> 
> I looked and saw that others (specifically samsung) had submitted this
> fix directly to Linus.  I'm still learning the ropes here and am happy
> to hear some clarification either way.
Note that just me wondering if it's right doesn't necessarily means it's
not.  Russell, can you comment?  Is it trivial enough and obviously only
tegra related that it's OK?
 
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
