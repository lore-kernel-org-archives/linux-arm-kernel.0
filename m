From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Feb 2015 20:56:44 +0800
Subject: [PATCH v3 0/2] ARM: imx6sx-sdb: add revb board
In-Reply-To: <1424939310-19282-1-git-send-email-peter.chen@freescale.com>
References: <1424939310-19282-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20150226125642.GI20028@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 04:28:28PM +0800, Peter Chen wrote:
> Changes for v3:
> - Rebased on v4.0-rc1
> 
> Changes for v2:
> 
> - Add missing Makefile entries for both dts files. [Patch 1/2] and [Patch 2/2]
> - Delete OOP setting changed at imx6sx-sdb-reva, it is SoC feature,
>   it doesn't need to be change unless board limitations. [Patch 1/2]
> - Add explanation why OOP setting need to changed at imx6sx-sdb revb board. [Patch 2/2]
> - Make imx6sx-sdb revb board as default imx6sx-sdb board. [Patch 2/2]
> 
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
> Peter Chen (2):
>   ARM: imx6sx-sdb: change default board as reva board
>   ARM: imx6sx-sdb: add revb board and make it default

Applied both, thanks.
