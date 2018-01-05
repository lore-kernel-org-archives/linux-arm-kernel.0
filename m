From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 23:18:29 -0800
Subject: [GIT PULL 2/3] Allwinner DT64 changes for 4.16
In-Reply-To: <20171228063044.GA4103@wens.csie.org>
References: <20171228062444.GA3883@wens.csie.org>
 <20171228063044.GA4103@wens.csie.org>
Message-ID: <20180105071829.knvg3vecumh6g4az@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 02:30:44PM +0800, Chen-Yu Tsai wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.16
> 
> for you to fetch changes up to 36252668c14ca14691d40c3455849ac5d8a60b62:
> 
>   arm64: dts: allwinner: a64: bananapi-m64: Add LED device node (2017-12-08 10:39:53 +0100)
> 
> ----------------------------------------------------------------
> Allwinner DT64 changes for 4.16
> 
> There are two important changes in this round.
> 
> The first removes the redundant pinctrl setting for the MMC card detect
> GPIO. We are moving to strict pinctrl/GPIO exclusion, i.e. GPIO usage
> will block other pin muxing usage, and vice versa. The usage of pinmux
> for guarding GPIO pins in the device tree prevents us from doing so.
> This is part of an ongoing effort to clean up the existing device trees.
> 
> The other important change enables the PMIC on the Orangepi Win. The
> PMIC provides power to most of the external onboard peripherals.
> Enabling it will allow us to enable Ethernet or WiFi support later on.
> 
> The remaining changes in this round enable some peripheral, such as
> Ethernet, an external WiFi chip, or LEDs.

Merged, thanks!


-Olof
