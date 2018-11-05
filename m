From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2018 06:39:51 -0800
Subject: [GIT PULL] i.MX fixes for 4.20
In-Reply-To: <20181105030750.GC24464@tiger>
References: <20181105030750.GC24464@tiger>
Message-ID: <20181105143951.lhlr4furkysuwf33@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 11:07:52AM +0800, Shawn Guo wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.20
> 
> for you to fetch changes up to 1ad9fb750a104f51851c092edd7b3553f0218428:
> 
>   ARM: dts: imx6sx-sdb: Fix enet phy regulator (2018-11-05 10:11:04 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 4.20:
>  - Add boot-on and always-on for imx6sx-sdb phy regulator to fix enet
>    resume problem, which is exposed by commit ("regulator: fixed:
>    Convert to use GPIO descriptor only").
>  - Fix improperly quoted stdout-path values for imx53-ppd and
>    vf610m4-colibri board.
>  - Fix the typo of compatible string "fs,imx6sll-i2c" which should be
>    "fsl,imx6sll-i2c".

Merged, thanks!


-Olof
