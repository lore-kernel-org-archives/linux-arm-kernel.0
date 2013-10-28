From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 13:21:19 -0700
Subject: [GIT PULL 1/2] ARM: imx: soc changes for 3.13
In-Reply-To: <20131021023533.GE17165@S2101-09.ap.freescale.net>
References: <20131021023533.GE17165@S2101-09.ap.freescale.net>
Message-ID: <20131028202119.GA4802@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 10:35:35AM +0800, Shawn Guo wrote:
> This is the imx/mxs soc changes I queued for 3.13.  A couple of notes:
> 
> * Since mach-mxs patch volume drops a lot, I start collecting mxs
>   patches using imx branch from this cycle.  Hope it's fine.
> 
> * The change set conflicts with Sebastian's .init_time cleanup series
>   quite badly.  The pull request is based on his branch [1] to solve
>   those conflicts.
> 
> Shawn
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg276175.html
> 
> The following changes since commit 6886530bab1e059a0fc5bab9813c739413d033bf:
> 
>   Merge remote-tracking branch 'shesselba/clk-of-init-v2_for-3.13' into imx/soc (2013-10-21 09:10:56 +0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.13
> 
> for you to fetch changes up to 9ba64fe3eb461b95bf11436a13db0d9c79465514:
> 
>   ARM: imx: enable suspend for imx6sl (2013-10-21 09:39:27 +0800)
> 
> ----------------------------------------------------------------
> The imx/mxs soc changes for 3.13:
> 
> * Low-level debug support for Vybrid
> * Support soc bus/device for imx6
> * Suspend support for imx6dl and imx6sl
> * The imx6q clock updates for PCIe and audio PLL support
> * IOMUXC GPR update for fec support
> * Some random cleanup
> * A few defconfig updates

Pulled, thanks.


-Olof
