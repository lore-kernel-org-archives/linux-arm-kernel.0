From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 23 Aug 2013 12:16:40 -0700
Subject: [GIT PULL v2 3/5] ARM: imx: device tree changes for 3.12
In-Reply-To: <20130822155931.GB8111@S2101-09.ap.freescale.net> (Shawn Guo's
 message of "Thu, 22 Aug 2013 23:59:32 +0800")
References: <20130822155931.GB8111@S2101-09.ap.freescale.net>
Message-ID: <87wqnckyjr.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@linaro.org> writes:

> Changes since v1:
>  * Rebase on [GIT PULL v2 2/5] ARM: imx: soc changes for 3.12

Thanks.

> The following changes since commit a1d63ff80b4f498fd6959c86e81add7902835657:
>
>   Merge tag 'imx-soc-3.12' into imx/dt (2013-08-22 23:26:50 +0800)
>
> are available in the git repository at:
>
>
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.12
>
> for you to fetch changes up to d45393cd32016ea76a364d1f2e7b58720b2f8135:
>
>   ARM: dts: vf610-twr: enable i2c0 device (2013-08-22 23:30:05 +0800)
>
> ----------------------------------------------------------------
> It contains the imx device tree updates for 3.12.
>
> - New pinctrl entry additions for various peripherals
> - Devices enabling for imx6, imx5 and imx27 boards
> - Add missing device nodes like iim, owire, audmux and sram, etc.
> - Various updates on boards like phytec, wandboard and sabresd
> - Consolidate pad macros between imx6q and imx6dl

Pulled into next/soc (not next/dt, due to depedency on your soc branch.)

Kevin
