From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 16:55:58 +0200
Subject: [GIT PULL 1/7] omap soc fixes for v3.11 merge window
In-Reply-To: <pull-1371578847-800598>
References: <pull-1371578847-800598>
Message-ID: <201306201655.58794.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Tony Lindgren wrote:
> The following changes since commit 4f288f081bb67813d35c10d1b2fa68e863c4b188:
> 
>   ARM: OMAP2+: AM43x: SRAM base and size (2013-06-12 08:07:23 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/soc-part2-signed
> 
> for you to fetch changes up to 7bcad170154f1302aeeced4f236588091a261fbf:
> 
>   ARM: OMAP3+: am33xx id: Add new am33xx specific function to check dev_feature (2013-06-18 03:04:07 -0700)
> 
> ----------------------------------------------------------------
> Fix am43x minimal booting as I accidentally left out one
> patch from the already merged omap-for-v3.11/soc-signed branch.
> Also fixes for ti81x booting and  revision check updates.
> 
> These are based on omap-for-v3.11/soc-signed because of the
> am43x dependency to earlier patches.
> 

Pulled into next/soc, thanks!

	Arnd
