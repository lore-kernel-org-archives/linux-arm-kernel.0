From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 31 Oct 2011 00:39:41 +0200
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <4EAB1BFF.3070406@gmail.com>
References: <4EA5DADC.7030805@gmail.com> <4EAB1BFF.3070406@gmail.com>
Message-ID: <201110302339.42341.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 October 2011, Rob Herring wrote:
> Here's an updated pull request to fix missing export.h include. Now it's
> also dependent on module.h clean-up branch:
> 
> git://openlinux.windriver.com/people/paulg/linux-next for-sfr
> 
> 
> The following changes since commit fa1d6d372245a160eecf5f57d64d2b21ea248e08:
> 
>   Merge branch 'for-sfr' of
> git://openlinux.windriver.com/people/paulg/linux-next into HEAD
> (2011-10-28 15:51:07 -0500)
> 
> are available in the git repository at:
> 
>   git://sources.calxeda.com/kernel/linux.git gic-dt

I've pulled it and am now trying to clean up the mess resulting from
having the previous version in a number of branches already.

Can you check that the highbank/soc branch is ok this time?

	Arnd
