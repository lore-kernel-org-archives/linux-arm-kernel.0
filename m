From: konkers@android.com (Erik Gilling)
Date: Fri, 3 Sep 2010 12:19:26 -0700
Subject: [PATCH 1/7] ARM: specify ZRELADDR for ARCH_TEGRA
In-Reply-To: <20100903190155.GE17152@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTi=7+TcOWu_62EWH6pwFUuizMT47tHJraaqzdJgp@mail.gmail.com>
	<20100903190155.GE17152@pengutronix.de>
Message-ID: <AANLkTin2fEj2kRRoE+RSpBovApMaCKTs+DVz9wvj7M3u@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 3, 2010 at 12:01 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Sep 03, 2010 at 10:46:43AM -0700, Erik Gilling wrote:
>> Yeah I saw that and posted a patch on the 27th and sent a pull request
>> to Linus on Wednesday. ?Hopefully it will make rc4.
> OK for me, I'll keep it in my queue and will drop it when Linus got
> the change. ?You didn't remove the line from
> arch/arm/mach-tegra/Makefile.boot, though.

I'll do that too.

> (hmm, I thought that patches that touch common files like
> arch/arm/Kconfig should go via rmk?!)

I looked and saw that others (specifically samsung) had submitted this
fix directly to Linus.  I'm still learning the ropes here and am happy
to hear some clarification either way.

> (BTW, I think lines like
> Change-Id: Ic28177a645e2d5bc53099c15dcd5b1ae7f3d5208 in the commit log
> are OK in general if they help you in any way. ?Maybe just prefix it
> something unique, 'Android-Change-Id:'?)

These are used by our code review system
(https://review.source.android.com) so changing the name is just as
easy as taking it out.  Plus the patches that end up getting posted
are rarely the same ones that are on top of our own tree.

-Erik
