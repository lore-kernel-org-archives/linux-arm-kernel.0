From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 3 Jan 2013 10:03:43 +0000
Subject: [RFC PATCH v3 13/16] ARM: dts: add AM33XX MMC support
In-Reply-To: <1350566815-409-14-git-send-email-mporter@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-14-git-send-email-mporter@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB3402D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt,

On Thu, Oct 18, 2012 at 18:56:52, Porter, Matt wrote:
> Adds AM33XX MMC support for am335x-bone and am335x-evm.

I want to test Suspend/Resume feature on omap hsmmc driver. 
Do you any tree based on mainline kernel v3.8-rc1 with these edma & mmc
patches.

> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts |    6 ++++++
>  arch/arm/boot/dts/am335x-evm.dts  |    6 ++++++
>  arch/arm/boot/dts/am33xx.dtsi     |   27 +++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
> 

..snip..
..snip..
..snip..


Regards, 
Gururaja
