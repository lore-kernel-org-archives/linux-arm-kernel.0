From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Sun, 12 Nov 2017 23:22:51 +0300
Subject: [PATCH 2/2] arm64: dts: orange-pi-zero-plus2: enable AP6212a
 WiFi/BT combo
In-Reply-To: <20171103195855.15283-3-geomatsi@gmail.com>
References: <20171103195855.15283-1-geomatsi@gmail.com>
 <20171103195855.15283-3-geomatsi@gmail.com>
Message-ID: <20171112202251.or3ezbsqyugmlqwl@speedy.hunter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Enable AP6212a WiFi/BT combo chip on orange-pi-zero-plus2 board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi REG_ON pin connected to gpio PA9: attach to mmc-pwrseq
> - WiFi HOST_WAKE pin connected to gpio PL7
> - BT is connected to UART1

Hi Maxime and all,

Any comments regarding this patch ?

Regards,
Sergey
