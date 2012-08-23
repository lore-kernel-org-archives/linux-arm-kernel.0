From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Aug 2012 15:05:46 +0000
Subject: [GIT PULL] imx fixes for 3.6 (take 2)
In-Reply-To: <20120823093407.GE24242@S2101-09.ap.freescale.net>
References: <20120823093407.GE24242@S2101-09.ap.freescale.net>
Message-ID: <201208231505.46361.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 August 2012, Shawn Guo wrote:
> are available in the git repository at:
>   git://git.linaro.org/people/shawnguo/linux-2.6.git imx/fixes-for-3.6
> 
> Philipp Zabel (1):
>       ARM i.MX6q: Add virtual 1/3.5 dividers in the LDB clock path
> 
> Shawn Guo (3):
>       ARM: imx6q: remove imx_src_prepare_restart() call
>       ARM: imx6: spin the cpu until hardware takes it down
>       ARM: dts: imx51-babbage: fix esdhc cd/wp properties

Pulled into the fixes branch now, without the "ARM: imx6q: remove
imx_src_prepare_restart() call" patch.

Thanks,

	Arnd
