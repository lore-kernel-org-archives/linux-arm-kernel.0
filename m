From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 21:43:28 +0200
Subject: [GIT PULL 6/7] omap gpmc reworked suspend patch for v3.11 merge
 window
In-Reply-To: <0M3kR7-1TyPb31W1B-00qrci@mx.kundenserver.de>
References: <0M3kR7-1TyPb31W1B-00qrci@mx.kundenserver.de>
Message-ID: <201306202143.28976.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Tony Lindgren wrote:
> The following changes since commit b3f5525c55ce5cb67af06f04dbbf28358da23a2c:
> 
>   ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable (2013-06-12 09:56:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/gpmc-part2-signed
> 
> for you to fetch changes up to b536dd412b4364df2f9495c6550ee38f6ad3b0fe:
> 
>   ARM: OMAP2+: gpmc: Low power transition support (2013-06-18 03:46:39 -0700)
> 
> ----------------------------------------------------------------
> GPMC suspend patch that was left out of the earlier
> omap-for-v3.11/gpmc-signed branch because of a compile error
> it caused. The compile error is fixed in this version.
> 

Pulled into next/drivers, thanks!

	Arnd
