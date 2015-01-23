From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 13:46:37 -0800
Subject: [GIT PULL 1/3] drop legacy booting for omap3517
In-Reply-To: <54be9e8b.6a58460a.68af.6889SMTPIN_ADDED_BROKEN@mx.google.com>
References: <54be9e8b.6a58460a.68af.6889SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20150123214637.GA20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 10:25:38AM -0800, Tony Lindgren wrote:
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/drop-legacy-3517-v2
> 
> for you to fetch changes up to 549f95ed20168daa06901054a028e185ebb905ab:
> 
>   ARM: OMAP3: Add back Kconfig option MACH_OMAP3517EVM for ASoC (2015-01-20 08:49:08 -0800)
> 
> ----------------------------------------------------------------
> We have had omap3517 booting in device tree mode for quite some
> time now and we have at least a minimal dts file for the 3517
> based boards. Also almost all the drivers are usable in device
> tree mode. And if there are any drivers not yet supported in device
> tree mode, those can be enabled using pdata quirks.
> 
> This leaves omap3430 to omap3730 as the only remaining mach-omap2
> platforms still booting in legacy mode also. For those were are
> printing a warning during the boot to get people to update their
> systems to boot in device tree mode and slowly converting them
> over to device tree based booting.

Merged into next/cleanup. Thanks!


-Olof
