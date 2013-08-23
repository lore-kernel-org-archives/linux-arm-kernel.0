From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 23 Aug 2013 12:16:08 -0700
Subject: [GIT PULL v2 2/5] ARM: imx: soc changes for 3.12
In-Reply-To: <20130822155404.GA8111@S2101-09.ap.freescale.net> (Shawn Guo's
 message of "Thu, 22 Aug 2013 23:54:07 +0800")
References: <20130822155404.GA8111@S2101-09.ap.freescale.net>
Message-ID: <871u5kmd53.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@linaro.org> writes:

> Changes since v1:
>  * Drop patch 'ARM: imx: add low-level debug for vybrid'

Thanks.

> The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:
>
>   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.12
>
> for you to fetch changes up to dc76a1adfa12ad11957bdeec565dbccf37205d04:
>
>   phy: micrel: Add definitions for common Micrel PHY registers (2013-08-22 23:20:54 +0800)
>
> ----------------------------------------------------------------
> It contains a bunch of imx soc updates for 3.12.
>
> - Add more ethernet phy fixups for imx6 boards
> - Add some missing imx6q clocks into clock driver
> - Add new clock types fixup mux and div to work around some ugly
>   hardware defect
> - Consolidate L2 cache initialization function, so that it can be used
>   on more i.MX SoCs
> - Replace magic numbers in mach-imx6q.c with well defined macros
> - Small fixes for imx6q and pllv3 clock drivers
> - Some random updates on imx defconfig files

Pulled into next/soc

Kevin
