From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 20:57:34 +0800
Subject: [GIT PULL] imx uncompress debug for 3.9
In-Reply-To: <20130110125547.GB8680@S2101-09.ap.freescale.net>
References: <20130110125547.GB8680@S2101-09.ap.freescale.net>
Message-ID: <CAAQ0ZWSdSU-pbLs9G9iouhhGvu1JtU==RA+qvkYGFA2to2aaNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forgot LAKML.  Sorry.

Shawn

On 10 January 2013 20:55, Shawn Guo <shawn.guo@linaro.org> wrote:
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
>
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-uncompress-3.9
>
> for you to fetch changes up to 0edbac9d72158b443368d7002db387463fe08ffd:
>
>   ARM: uncompress: support uncompress debug for multiplatform build (2012-12-22 21:01:50 +0800)
>
> ----------------------------------------------------------------
> I did not get any comment on the series, so would think it's an
> acceptable solution for multiplatform build to get uncompress debug
> capability back.
>
> ----------------------------------------------------------------
> Shawn Guo (4):
>       ARM: imx: use separated debug uart symbol for imx31 and imx35
>       ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs
>       ARM: imx: restore uncompress.h to a common place
>       ARM: uncompress: support uncompress debug for multiplatform build
>
>  arch/arm/Kconfig.debug                    |   44 ++++++++++++---
>  arch/arm/boot/compressed/misc.c           |    8 +--
>  arch/arm/include/debug/imx-uart.h         |   88 +++++++++++++++++++++++++++++
>  arch/arm/include/debug/imx.S              |   29 +---------
>  arch/arm/include/debug/uncompress/dummy.h |    3 +
>  arch/arm/include/debug/uncompress/imx.h   |   63 +++++++++++++++++++++
>  6 files changed, 191 insertions(+), 44 deletions(-)
>  create mode 100644 arch/arm/include/debug/imx-uart.h
>  create mode 100644 arch/arm/include/debug/uncompress/dummy.h
>  create mode 100644 arch/arm/include/debug/uncompress/imx.h
