From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 17:33:10 +0100
Subject: [GIT PULL] ARM: imx: device tree changes for 3.19
In-Reply-To: <20141119070752.GG27759@dragon>
References: <20141119070752.GG27759@dragon>
Message-ID: <201411201733.10706.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014, Shawn Guo wrote:
> Hi Olof, Arnd,
> 
> This pull request is based on the SoC pull request which tagged as
> imx-soc-3.19.  Please pull, thanks.
> 
> Shawn
> 
> The following changes since commit dc7aaa041842eb40be7ad7bde0a7e37ac1efd79c:
> 
>   ARM: configs: imx_v6_v7_defconfig: add power off driver (2014-11-19 11:51:55 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.19
> 
> for you to fetch changes up to c95e259674da685152eb093263478c7ada0aa904:
> 
>   ARM: dts: imx6: add pm_power_off support for i.mx6 chips (2014-11-19 11:59:38 +0800)
> 
> ----------------------------------------------------------------
> The i.MX device tree changes for 3.19:
>  - Device additions for board vf610-colibri, pwm, backlight, I2C, RTC,
>    ADC etc.
>  - Update i.MX6 phyFLEX board to include PCIe, CAN and audio support
>  - Improve SSI clocks description for i.MX5 platforms
>  - Add ENET2 support for imx6sx-sdb board
>  - Add device tree source for LS1021A SoC, board QDS and TWR
>  - Enable cpufreq support for i.MX53
>  - Enable VPU device support for i.MX6QDL
>  - Enable poweroff support for i.MX6 SoCs
>  - Add support for TBS2910 Matrix ARM mini PC which is built on i.MX6Q
>  - Create generic base device trees for Vybrid and add support for
>    Colibri VF50
> 

Again, all changes here look good to me, but as it's based on top of hte
other branch, please rebase again. Can you also explain in the tag
description why you have based on the other branch? I assume you had
a good reason, but it's not obvious to me.

	Arnd
