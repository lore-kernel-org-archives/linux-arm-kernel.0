From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 Aug 2016 17:29:02 -0700
Subject: [GIT PULL] i.MX fixes for 4.8
In-Reply-To: <20160818004118.GA20221@tiger>
References: <20160818004118.GA20221@tiger>
Message-ID: <20160826002902.GA8515@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 08:41:18AM +0800, Shawn Guo wrote:
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> 
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.8
> 
> for you to fetch changes up to cfee6b5874654fe4e7388bc3112d3afb76cd8b9e:
> 
>   ARM: imx6ul: populates platform device at .init_machine (2016-08-17 22:43:05 +0800)
> 
> ----------------------------------------------------------------
> The i.MX fixes for 4.8:
>  - Fix typo in imx6sx-sabreauto board wakeup property
>  - Fix i.MX6UL suspend-to-standby support by adding the
>    BM_CLPCR_BYP_MMDC_CH0_LPM_HS handling
>  - Fix a i.MX6UL regression on suspend support, which is caused by
>    commit 850bea2335e4 ("arm: Remove unnecessary of_platform_populate
>    with default match table")
> 
> ----------------------------------------------------------------
> Andreas F?rber (1):
>       ARM: dts: imx6sx-sabreauto: Fix misspelled property
> 
> Peter Chen (2):
>       ARM: imx6: add missing BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul
>       ARM: imx6ul: populates platform device at .init_machine

Merged, thanks.


-Olof
