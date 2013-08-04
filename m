From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Aug 2013 13:36:53 -0700
Subject: [GIT PULL] ARM: OMAP2+: hwmod fixes for v3.11-rc
In-Reply-To: <20130730133336.GL7656@atomide.com>
References: <alpine.DEB.2.02.1307301146110.4505@utopia.booyaka.com>
 <20130730133336.GL7656@atomide.com>
Message-ID: <20130804203653.GF15602@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 06:33:36AM -0700, Tony Lindgren wrote:
> Arnd & Olof,
> 
> Can you please take this pull request directly? Other than the
> omap5 regulator dts changes I just posted I don't yet have
> anything else queued up right now.


Pulled. But Paul, if you don't mind, please base your fixes on older -rcs
unless there's a reason to go with the latest-and-greatest.

I had to rebase our fixes branch since this pulled in a newer -rc than
ours and I didn't want to have a back-merge in the history.


Thanks,

-Olof
