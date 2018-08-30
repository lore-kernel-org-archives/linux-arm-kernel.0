From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 30 Aug 2018 23:53:50 +0200
Subject: [PATCH v2 1/2] ARM: configs: at91: add generic resistive
 touchscreen to sama5
In-Reply-To: <1535552264-8923-1-git-send-email-eugen.hristev@microchip.com>
References: <1535552264-8923-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180830215350.GL16561@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/2018 17:17:43+0300, Eugen Hristev wrote:
> Add generic resistive touchscreen CONFIG_TOUCHSCREEN_ADC to sama5_defconfig
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
> - split config change into two commits, per defconfig
> 
>  arch/arm/configs/sama5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
Both applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
