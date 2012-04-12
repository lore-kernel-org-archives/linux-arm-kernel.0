From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Apr 2012 10:56:28 +0200
Subject: [PATCH 00/13] common clk framework misc fixes
In-Reply-To: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
Message-ID: <20120412085628.GE20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 06:02:38PM -0700, Mike Turquette wrote:
> This series collects many of the fixes posted for the recently merged
> common clock framework as well as some general clean-up.  Most of the
> code classifies as a clean-up moreso than a bug fix; hopefully this is
> not a problem since the common clk framework is new code pulled for 3.4.
> 
> Patches are based on v3.4-rc2 and can be pulled from:
> git://git.linaro.org/people/mturquette/linux.git v3.4-rc2-clk-fixes
> 
> Please let me know I missed any critical fixes that were posted to the
> list already.
> 
> Arnd & Olof, if there are no objections to these changes can this get
> pulled through the arm-soc tree?

I had a look at this series and except for the comment Shawn already
made I am fine with it. I also vote for queuing it during -rc since
the framework currently has no users and letting it into -rc will help
people like me putting SoC support onto it.

Except the last patch:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
