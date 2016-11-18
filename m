From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 10:32:35 -0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.10
In-Reply-To: <1479200431-1765-4-git-send-email-shawnguo@kernel.org>
References: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
 <1479200431-1765-4-git-send-email-shawnguo@kernel.org>
Message-ID: <20161118183235.GG8882@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 05:00:30PM +0800, Shawn Guo wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.10
> 
> for you to fetch changes up to 236f794e4463a6b53139702c1b609091f61a17ab:
> 
>   arm64: dts: ls2080a: Add TMU device tree support for LS2080A (2016-11-15 15:05:36 +0800)
> 
> ----------------------------------------------------------------
> Freescale arm64 device tree updates for 4.10:
>  - Enable Thermal Monitoring Unit (TMU) for thermal management on
>    LS1043A and LS2080A.
>  - Add support for LS1046A SoC, which has similar peripherals as
>    LS1043A but integrates 4 A72 cores.
>  - Add two LS1046A based board support: LS1046A-QDS and LS1046A-RDB.

Merged, thanks.


-Olof
