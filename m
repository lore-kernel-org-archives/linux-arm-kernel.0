From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 14:59:22 +0100
Subject: [GIT PULL v2] ARM: imx: cleanup for 3.19
In-Reply-To: <20141123083353.GE11253@dragon>
References: <20141123083353.GE11253@dragon>
Message-ID: <201411281459.22594.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 November 2014, Shawn Guo wrote:
> Changes since v1:
>  - Rebase the change set on 3.18-rc3
> 
> The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:
> 
>   Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-3.19
> 
> for you to fetch changes up to b50e7df946138399832af8f2b067fa6c3256a005:
> 
>   ARM: imx: Remove unneeded .map_io initialization (2014-11-22 07:39:36 +0800)
> 
> ----------------------------------------------------------------
> The i.MX cleanup for 3.19:
>  - Clean up reset handler for DT machines, since reset has been handled
>    in watchdog driver
>  - Remove unneeded .map_io hook for a couple of i.MX6 machines
>  - A few small i.MX6 device tree source cleanups
>  - Some random iomuxc and pllv3 code cleanup

Pulled into next/cleanup, thanks!

	Arnd
