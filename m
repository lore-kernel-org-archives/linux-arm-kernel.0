From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Jul 2018 09:47:59 -0700
Subject: i.MX fixes for 4.18, round 2
In-Reply-To: <20180703134422.GV4348@dragon>
References: <20180703134422.GV4348@dragon>
Message-ID: <20180703164759.6ljtckniqhyfh6di@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 09:44:23PM +0800, Shawn Guo wrote:
> The following changes since commit 1bcfe0564044be578841744faea1c2f46adc8178:
> 
>   ARM: dts: imx6sx: fix irq for pcie bridge (2018-06-19 14:39:36 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.18-2
> 
> for you to fetch changes up to 2ceb2780b790b74bc408a949f6aedbad8afa693e:
> 
>   ARM: imx_v4_v5_defconfig: Select ULPI support (2018-07-03 21:12:04 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 4.18, round 2:
>  - A couple of imx defconfig updates selecting USB ULPI support to fix
>    a regression seen with USB driver, which is caused by commit
>    03e6275ae381 ("usb: chipidea: Fix ULPI on imx51").
>  - A fix on imx51-zii-rdu1 board touchscreen pinctrl setting, which
>    causes an interrupt storm.

Merged, thanks!


-Olof
