From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Jan 2013 23:10:08 +0800
Subject: [GIT PULL] imx cleanup for 3.9
In-Reply-To: <20130129141857.GA12723@quad.lixom.net>
References: <20130122144813.GD2812@S2101-09.ap.freescale.net>
 <20130128220026.GC3047@quad.lixom.net>
 <20130129010853.GA24352@S2101-09.ap.freescale.net>
 <20130129072603.GL1906@pengutronix.de>
 <20130129141857.GA12723@quad.lixom.net>
Message-ID: <20130129151005.GC11345@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 06:18:57AM -0800, Olof Johansson wrote:
> Ok. Just to make clear: While I personally prefer the regular way of specifying
> the board dts files, my main concern with this patch is that it is _pure
> churn_. It's 1000 lines of change without a functional benefit, and without
> really being a cleanup that benefits long-term development.
> 
You can say it's not a cleanup, but it definitely benefits long-term
development.  It makes board dts development a lot easier, and that's
why I came up with the patch.

> We're starting to get more comments about the volume of churn again (Linus made
> a couple of them the last merge window), and I'd rather be a bit more
> conservative on some of the larger changes that lack strong benefit for
> a release or two, than have him get ticked off and make life miserable for all
> of us.
> 
> So, I'm not saying that it's a bad idea to change to labels, but I would rather
> hold off this while we give some of the remaining platforms still not
> multiplatform-enabled a chance to "use the churn quota" since they will need it
> for include file moves, etc, etc.
> 
Then it will hold off the while IMX device tree development.  All the
patches I queued on imx/dt branch are all based on that.  While it
looks like a "churn", it should not cause any conflict, as all IMX
dts changes will go via the same branch for this cycle.  So please
give it a go to avoid hurting people who contribute IMX device tree
development.

Shawn
