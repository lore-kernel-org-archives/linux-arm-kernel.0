From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 15:03:47 +0100
Subject: [GIT PULL v2] ARM: imx: device tree changes for 3.19
In-Reply-To: <20141123084150.GG11253@dragon>
References: <20141123084150.GG11253@dragon>
Message-ID: <201411281503.48154.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 November 2014, Shawn Guo wrote:
> Changes since v1:
>  - Rebase on v3.18-rc3
>  - Add a note into tag description to tell the dependency on mx-soc-3.19
>  - Add one patch from Soeren enabling snvs-poweroff for imx6q-tbs2910
> 
> The following changes since commit 2ce34b105c79ee0404b3a8f68c9ab2ce197dd06f:
> 
>   Merge tag 'imx-soc-3.19' into imx/dt (2014-11-23 15:07:02 +0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.19
> 
> for you to fetch changes up to 96acf9dfe1ba59e99eafcf26478118edd195d924:
> 
>   ARM: dts: imx6q-tbs2910: Enable snvs-poweroff (2014-11-23 16:13:28 +0800)
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
> Note: the change set is built on top of imx-soc-3.19 to resolve the
> dependency that  "ARM: dts: imx53: add cpufreq-dt support" uses the
> clock define IMX5_CLK_ARM that is added by "ARM: imx53: clk: add ARM
> clock".
> 

Pulled into next/dt, thanks!

	Arnd
