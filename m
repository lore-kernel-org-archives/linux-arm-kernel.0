From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 15 Nov 2018 15:57:53 +0100
Subject: [PATCH] ARM: dts: rockchip: Fix Rock2 vcc_flash name
In-Reply-To: <20181113152413.11386-1-john@metanate.com>
References: <20181113152413.11386-1-john@metanate.com>
Message-ID: <4092354.udJuV4aAHT@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 13. November 2018, 16:24:13 CET schrieb John Keeping:
> There is no functional change from this, but it is confusing to find two
> copies of vcc_sys and no vcc_flash when looking in
> /sys/class/regulator/*/name.
> 
> Signed-off-by: John Keeping <john@metanate.com>

applied for 4.21, thanks for catching that typo


Heiko
