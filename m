From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 May 2015 18:22:43 +0200
Subject: [GIT PULL] ARM: imx: fixes for 4.1
In-Reply-To: <20150429145321.GA20956@dragon>
References: <20150429145321.GA20956@dragon>
Message-ID: <201505071822.43216.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015, Shawn Guo wrote:
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
> 
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.1
> 
> for you to fetch changes up to 68ce9a1f24b8e8894955032a4af74998315be9fe:
> 
>   ARM: dts: imx6qdl-sabreauto: remove pinctrl-assert-gpios (2015-04-28 09:05:21 +0800)
> 
> ----------------------------------------------------------------
> The i.MX fixes for 4.1:
>  - A couple of imx23-olinuxino device tree fixes regarding to LED GPIO
>    polarity and USB dr_mode setting
>  - One i.MX28 device tree fix on AUART4 TX-DMA interrupt name
>  - Add missing pwm-cells to PWM4 for i.MX25 device tree
>  - Fix imx6q-phytec device tree to get correct USB VBUS control
>  - Drop invalid pinctrl-assert-gpios property from imx6qdl-sabreauto
>    device tree, which was sneaked in from vendor device tree
>  - One fix on Wolfram's broken email address

Pulled into the fixes branch, thanks!

	Arnd
