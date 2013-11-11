From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Nov 2013 09:51:50 -0800
Subject: [GIT PULL] ARM: imx: fixes for 3.13
In-Reply-To: <20131111153124.GD11083@S2101-09.ap.freescale.net>
References: <20131111153124.GD11083@S2101-09.ap.freescale.net>
Message-ID: <20131111175150.GB8809@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 11:31:51PM +0800, Shawn Guo wrote:
> The following changes since commit edae583a6d4d1ad2eb73981787790993fef1bbad:
> 
>   Merge tag 'arc-v3.13-rc1-part1' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc (2013-11-11 18:19:06 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.13
> 
> for you to fetch changes up to 036e29918078e38b0b127b89deb4c595028c1bc0:
> 
>   ARM: dts: i.MX51: Fix OTG PHY clock (2013-11-11 22:58:45 +0800)
> 
> ----------------------------------------------------------------
> The imx fixes for 3.13:
>  - A couple of imx5 and imx6 clock fixes
>  - Two follow-up patches for improving/fixing the commit "ARM: imx:
>    replace imx6q_restart()with mxc_restart()"
>  - One compile fix for imx6sl with randconfig
>  - Commits to fix pllv3 relock/power issues found in IPU/HDMI testing

Pulled, thanks!


-Olof
