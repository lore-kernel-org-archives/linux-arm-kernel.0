From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Feb 2015 15:58:41 +0800
Subject: [PATCH v2 0/2] ARM: imx6sx-sdb: add revb board
In-Reply-To: <1421804094-26379-1-git-send-email-peter.chen@freescale.com>
References: <1421804094-26379-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20150226075838.GF20028@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 09:34:52AM +0800, Peter Chen wrote:
> Hi Shawn,
> 
> The imx6sx-sdb board has two revisions, the current mainline is the
> reva which is experimental and will not be released, the revb board
> is used widely for internal and external users.
> 
> The main changes between reva and revb board:
> - OOP setting
> - pfuse
> - qspi
> - can transceiver (not mainlined)
> 
> Changes for v2:
> 
> - Add missing Makefile entries for both dts files. [Patch 1/2] and [Patch 2/2]
> - Delete OOP setting changed at imx6sx-sdb-reva, it is SoC feature,
>   it doesn't need to be change unless board limitations. [Patch 1/2]
> - Add explanation why OOP setting need to changed at imx6sx-sdb revb board. [Patch 2/2]
> - Make imx6sx-sdb revb board as default imx6sx-sdb board. [Patch 2/2]
> 
> Peter Chen (2):
>   ARM: imx6sx-sdb: change default board as reva board
>   ARM: imx6sx-sdb: add revb board and make it default

Peter,

What branch did you generate these patches on?  I'm trying to apply
them, but they do not apply on any reasonable branch.  Can you re-spin
against v4.0-rc1?  Thanks.

Shawn

> 
>  arch/arm/boot/dts/Makefile            |   3 +-
>  arch/arm/boot/dts/imx6sx-sdb-reva.dts | 143 +++++++++
>  arch/arm/boot/dts/imx6sx-sdb.dts      | 588 ++--------------------------------
>  arch/arm/boot/dts/imx6sx-sdb.dtsi     | 547 +++++++++++++++++++++++++++++++
>  4 files changed, 720 insertions(+), 561 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6sx-sdb-reva.dts
>  create mode 100644 arch/arm/boot/dts/imx6sx-sdb.dtsi
> 
> -- 
> 1.9.1
> 
