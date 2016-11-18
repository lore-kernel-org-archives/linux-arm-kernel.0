From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 09:59:37 -0800
Subject: [GIT PULL 2/5] i.MX soc updates for 4.10
In-Reply-To: <1479200431-1765-2-git-send-email-shawnguo@kernel.org>
References: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
 <1479200431-1765-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20161118175937.GE8882@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 05:00:28PM +0800, Shawn Guo wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.10
> 
> for you to fetch changes up to 75b832fea2564c547dfd0a2377a5893f41aefec6:
> 
>   ARM: imx: mach-imx6ul: add imx6ull support (2016-11-15 08:58:43 +0800)
> 
> ----------------------------------------------------------------
> i.MX SoC changes for 4.10:
>  - Drop PL310_ERRATA_769419 for Vybrid, as it turns out that the SoC
>    integrates revision r3p2 of the L2C-310, which is not affected by
>    errata 769419.
>  - Support perf for i.MX6 Multi-Mode DDR Controller (MMDC), so that we
>    can profile memory access performance.
>  - Support i.MX6ULL SoC using i.MX6UL base, since it's a derivative of
>    i.MX6UL and pin-to-pin compatible with i.MX6UL.

Merged, thanks.


-Olof
