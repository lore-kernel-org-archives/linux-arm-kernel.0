From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 10 Dec 2015 21:18:04 +0100
Subject: [PATCH 0/2] arm: dts: berlin: fix BG2Q sdhci clk
In-Reply-To: <1449493765-5111-1-git-send-email-jszhang@marvell.com>
References: <1449493765-5111-1-git-send-email-jszhang@marvell.com>
Message-ID: <5669DDFC.7010706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.12.2015 14:09, Jisheng Zhang wrote:
> CLKID_SDIO is used as the 2nd optional clk for all sdhci hosts in BG2Q.
> We removed CLK_IGNORE_UNUSED from CLKID_SDIO's flag. These two patches
> fixes this clk issue.
> 
> Jisheng Zhang (2):
>   ARM: dts: berlin: correct BG2Q's sdhci2 2nd clock
>   ARM: dts: berlin: add 2nd clock for BG2Q sdhci0 and sdhci1
> 
>  arch/arm/boot/dts/berlin2q.dtsi | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Series applied to berlin/fixes.

Thanks!

Sebastian
