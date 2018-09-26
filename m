From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 26 Sep 2018 13:38:53 +0200
Subject: [PATCH] arm64: dts: rockchip: Enable SPI NOR flash on Rock64
In-Reply-To: <20180926045357.20722-1-wens@csie.org>
References: <20180926045357.20722-1-wens@csie.org>
Message-ID: <2872521.VFYVRVU0oA@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. September 2018, 06:53:57 CEST schrieb Chen-Yu Tsai:
> The Pine64 Rock64 board comes with a GigaDevice GD25Q128CSIG
> or GD25Q127CSIG chip, which is a 128 Mbit SPI NOR flash chip
> that supports the JEDEC read-ID command.
> 
> This patch enables the SPI controller and adds a device node
> for the flash chip using the generic "jedec,spi-nor" comaptible.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

applied for 4.20

Thanks
Heiko
