From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Aug 2014 15:12:35 -0700
Subject: [GIT PULL] ARM: imx: fixes for 3.17, 2nd take
In-Reply-To: <20140827055110.GB28777@dragon>
References: <20140827055110.GB28777@dragon>
Message-ID: <20140827221235.GC13392@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 01:51:12PM +0800, Shawn Guo wrote:
> The following changes since commit 3bc4d037c6791c5089a04845995410aac4fdb514:
> 
>   ARM: dts: imx6sx: fix the pad setting for uart CTS_B (2014-08-19 20:06:59 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.17-2
> 
> for you to fetch changes up to bf8147208eab4a026558dcd686f76410de6c1643:
> 
>   ARM: dts: microsom-ar8035: MDIO pad must be set open drain (2014-08-27 13:32:26 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 3.17, 2nd take:
>  - Fixes suspend/resume issue on imx53-qsrb due to PMIC IRQ pin
>    configuration missing
>  - A couple small SolidRun board fixes/correction from Rabeeh
>    and Russell

Merged, thanks.


-Olof
