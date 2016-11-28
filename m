From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Nov 2016 10:56:06 +0530
Subject: [PATCH] ARM: dts: da850-lcdk: Add ethernet0 alias to DT
In-Reply-To: <20161124143545.12817-1-fparent@baylibre.com>
References: <20161124143545.12817-1-fparent@baylibre.com>
Message-ID: <fc94d2aa-7356-bf25-85e2-f7697ec8e985@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 November 2016 08:05 PM, Fabien Parent wrote:
> In order to avoid Linux generating a random mac address on every boot,
> add an ethernet0 alias that will allow u-boot to patch the dtb with
> the MAC address programmed into the EEPROM.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v4.10/dt. Thanks!

Regards,
Sekhar
