From: olof@lixom.net (Olof Johansson)
Date: Fri, 7 Jun 2013 18:19:13 -0700
Subject: [GIT PULL] ARM: imx: fixes for 3.10, take 2
In-Reply-To: <20130603150953.GA13853@S2101-09.ap.freescale.net>
References: <20130603150953.GA13853@S2101-09.ap.freescale.net>
Message-ID: <20130608011913.GA27720@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 11:09:56PM +0800, Shawn Guo wrote:
> The following changes since commit de78a23d73ba7f1d08f3e1aeaa0a03cb912c62a0:
> 
>   ARM: imx: fix typo in gpu3d_shader_sels (2013-05-12 21:39:51 +0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.10-2

Pulled, thanks.

> ----------------------------------------------------------------
> The imx fixes for 3.10, take 2:
> 
> - One device tree fix for all spi node to have per clock added.
>   The clock is needed by spi driver to calculate bit rate divisor.
>   The spi node in the current device trees either does not have the
>   clock or is defined as dummy clock, in which case the driver probe
>   will fail or spi will run at a wrong bit rate.
> 
> - Two imx6q clock fixes, which correct axi_sels and ldb_di_sels.

Are these regressions, or fixes for things that have never worked?


-Olof
