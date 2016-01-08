From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 11:49:20 +0100
Subject: [PATCH] ARM: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
In-Reply-To: <568B1E85.1040604@linaro.org>
References: <1451877536-21603-1-git-send-email-shawn.lin@rock-chips.com>
 <568B1E85.1040604@linaro.org>
Message-ID: <3975644.savFXEa5eR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 January 2016 09:38:13 Jun Nie wrote:
> On 2016?01?04? 11:18, Shawn Lin wrote:
> > dw_mmc driver never use this macro, so remove it from
> > zx_defconfig
> >
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>


> 
> Reviewed-by: Jun Nie <jun.nie@linaro.org>
> 

Applied, thanks!

	Arnd
