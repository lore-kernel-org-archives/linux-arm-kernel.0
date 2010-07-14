From: tony.luck@gmail.com (Tony Luck)
Date: Wed, 14 Jul 2010 10:37:07 -0700
Subject: ARM defconfig files
In-Reply-To: <20100714132046.GA18343@pengutronix.de>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<201007121605.32462.davidb@codeaurora.org>
	<AANLkTimho3rcoCZZ2PlC3B3KIZZhsEiTnTk-__n1q_Dy@mail.gmail.com>
	<201007121634.04427.davidb@codeaurora.org>
	<20100714132046.GA18343@pengutronix.de>
Message-ID: <AANLkTinMZw7ZuUpNPePwIRgkYCwFuxbk-xiuDm7HHBwF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/14 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Note that no kernel is built at all, only the config is regenerated once
> for each line.

You could special case blank lines and comments (other than ones
like "# CONFIG_FOO is not set" which do matter).  They account for
~15% of the lines in my .config files.  But it probably doesn't matter
all that much. I just ran reduce_defconfig in parallel on all the ia64
defconfig files (in separate build trees) and they were all done when
I looked back an hour or so later.  Nice tool!

-Tony
