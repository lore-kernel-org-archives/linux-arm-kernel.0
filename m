From: olof@lixom.net (Olof Johansson)
Date: Sat, 25 Oct 2014 20:44:39 -0700
Subject: [GIT PULL] ARM: imx: fixes for 3.18
In-Reply-To: <20141026013617.GF6973@tiger>
References: <20141026013617.GF6973@tiger>
Message-ID: <20141026034439.GA20496@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 26, 2014 at 09:36:18AM +0800, Shawn Guo wrote:
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.18
> 
> for you to fetch changes up to d1e61eb443dc7512885dfe89ee2f2a1c29fcb1da:
> 
>   ARM: dts: imx28-evk: Let i2c0 run at 100kHz (2014-10-25 20:17:36 +0800)
> 
> ----------------------------------------------------------------
> The i.MX fixes for 3.18:
>  - Revert one patch which increases I2C bus frequency on imx28-evk
>  - Fix a typo on imx6q EIM clock name

Merged, thanks.


-Olof
