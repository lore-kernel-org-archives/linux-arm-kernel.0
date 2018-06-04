From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 4 Jun 2018 11:09:19 +0200
Subject: [PATCH v3 2/2] arm64: allwinner: a64-amarula-relic: Enable
 AP6330 WiFi support
In-Reply-To: <20180601173527.18051-2-jagan@amarulasolutions.com>
References: <20180601173527.18051-1-jagan@amarulasolutions.com>
 <20180601173527.18051-2-jagan@amarulasolutions.com>
Message-ID: <20180604090919.s2mp7etd2eao3w6b@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 11:05:27PM +0530, Jagan Teki wrote:
> Enable AP6330 WiFi/BT combo chip on Amarula A64-Relic board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi WL-PMU-EN pin connected to gpio PL2: attach to mmc-pwrseq
> - WiFi WL-WAKE-AP pin connected to gpio PL3
> - 32kHz external oscillator gate clock from RTC
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied both, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/e54d5fa4/attachment.sig>
