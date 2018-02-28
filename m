From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Feb 2018 23:24:36 +0100
Subject: [GIT PULL] i.MX fixes for 4.16
In-Reply-To: <20180228001638.GX3217@dragon>
References: <20180228001638.GX3217@dragon>
Message-ID: <CAK8P3a1JNUN-XG6yJubQoD0DvZvCH52fgjX9ZKOdJH_rX-RG7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 1:16 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.16
>
> for you to fetch changes up to c0c6bb2322964bd264b4ddedaa5776f40c709f0c:
>
>   ARM: dts: imx6dl: Include correct dtsi file for Engicam i.CoreM6 DualLite/Solo RQS (2018-02-24 16:53:09 +0800)
>
> ----------------------------------------------------------------
> i.MX fixes for 4.16:
>  - Fix i.MX GPC driver to remove power domains only when they are
>    initialized in imx_gpc_probe().
>  - Fix the broken Engicam i.CoreM6 DualLite/Solo RQS board DT to include
>    imx6dl.dtsi instead of imx6q.dtsi.

Pulled into fixes, thanks!

       arnd
