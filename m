From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 May 2013 14:48:19 +0200
Subject: [GIT PULL] Urgent omap timer fix for current merge window
In-Reply-To: <20130506234610.GK28721@atomide.com>
References: <20130506234610.GK28721@atomide.com>
Message-ID: <201305071448.19868.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 May 2013, Tony Lindgren wrote:
> The following changes since commit dc2d3db8137fba0f62d7517e1bea8a47f69fcbc4:
> 
>   Merge tag 'omap-for-v3.10/timer-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/drivers (2013-04-08 19:30:48 +0200)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-for-merge-window
> 
> for you to fetch changes up to 08a48be32ff31d38bcfec7d210c954cb62fd5cd7:
> 
>   ARM: OMAP4: change the device names in usb_bind_phy (2013-05-06 16:39:16 -0700)
> 
> ----------------------------------------------------------------
> An urgent fix for a timer mismerge for and a regression fix for
> musb device naming change.
> 

Hi Tony,

Russell also ran into this problem, so I'm including these in the late/cleanup branch,
which I'll send to Linus later today.

Thanks,

	Arnd
