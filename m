From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 1 Jun 2018 17:06:28 +0200
Subject: [PATCH v2] arm64: allwinner: a64-amarula-relic: Enable AP6330
 WiFi support
In-Reply-To: <20180531165109.8476-1-jagan@amarulasolutions.com>
References: <20180531165109.8476-1-jagan@amarulasolutions.com>
Message-ID: <20180601150628.zqo6jjd6ch5dvqtl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 31, 2018 at 10:21:09PM +0530, Jagan Teki wrote:
> Enable AP6330 WiFi/BT combo chip on Amarula A64-Relic board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi WL-PMU-EN pin connected to gpio PL2: attach to mmc-pwrseq
> - WiFi WL-WAKE-AP pin connected to gpio PL3
> - 32kHz external oscillator gate clock from RTC
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Move external rtc clock nodes into main rtc node definition
>   of sun50i-a64.dtsi

Please make that a separate patch.

Maxime
-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180601/d1f386eb/attachment-0001.sig>
