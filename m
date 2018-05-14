From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 01:05:46 -0700
Subject: [GIT PULL] i.MX fixes for 4.17
In-Reply-To: <20180514063335.GI26863@dragon>
References: <20180514063335.GI26863@dragon>
Message-ID: <20180514080546.mrytfnab5sjyez7h@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 02:33:36PM +0800, Shawn Guo wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.17
> 
> for you to fetch changes up to 6d3299aef7df7225ecff653feedafb5d1646998b:
> 
>   ARM: dts: imx51-zii-rdu1: fix touchscreen bindings (2018-05-11 13:50:27 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 4.17:
>  - Add missing 'fsl,sec-era' property for i.MX7S device tree CAAM node,
>    as the era information is used in various places inside CAAM driver.
>  - There are a few errors in imx51-zii-rdu1 device tree touchscreen
>    node.  Fix them to get touchscreen actually work.

Merged, thanks!


-Olof
