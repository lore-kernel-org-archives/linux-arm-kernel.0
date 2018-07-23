From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 23 Jul 2018 12:40:56 +0200
Subject: [PATCH 1/5] arm64: defconfig: Enable sound support for Samsung
 Chromebook Plus.
In-Reply-To: <20180717160610.26501-1-enric.balletbo@collabora.com>
References: <20180717160610.26501-1-enric.balletbo@collabora.com>
Message-ID: <1845030.GmhzmUT5kH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 17. Juli 2018, 18:06:06 CEST schrieb Enric Balletbo i Serra:
> Enable the Rockchip sound driver with MAX98357A/RT5514/DA7219 codecs
> needed for the Samsung Chromebook Plus.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied all 5 for 4.19.

As Olof requested less granularity for defconfig changes, I squashed
all of them into one patch enabling Chromebook Plus peripherals.


Thanks
Heiko
