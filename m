From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Dec 2011 21:52:50 +0000
Subject: [GIT PULL] omap hwmod changes for v3.3 merge window
In-Reply-To: <20111219194818.GQ6464@atomide.com>
References: <20111219194818.GQ6464@atomide.com>
Message-ID: <201112272152.50502.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 December 2011, Tony Lindgren wrote:
> Hi Arnd & Olof,
> 
> Please pull omap hwmod changes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap hwmod
> 
> These changes are mostly needed for the USB *HCI support to
> behave. These depend on the fixes-non-critical-part2 posted
> earlier.
> 

Pulled into next/devel, and written down the dependency.
I wasn't sure about whether this should be next/pm or next/devel,
decided for next/devel in the end.

	Arnd
