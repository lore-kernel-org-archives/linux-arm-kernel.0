From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 07 Apr 2017 00:21:43 +0200
Subject: [PATCH v2 1/3] ARM: dts: rockchip: Add support for phyCORE-RK3288
 SoM
In-Reply-To: <1491483866-18368-1-git-send-email-w.egorov@phytec.de>
References: <1491483866-18368-1-git-send-email-w.egorov@phytec.de>
Message-ID: <2316800.SYqXzj6arr@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 6. April 2017, 15:04:24 CEST schrieb Wadim Egorov:
> The phyCORE-RK3288 is a SoM (System on Module) containing a RK3288 SoC.
> The module can be connected to different carrier boards.
> It can be also equipped with different RAM, SPI flash and eMMC variants.
> The Rapid Development Kit option is using the following setup:
> 
>   - 1 GB DDR3 RAM (2 Banks)
>   - 1x 4 KB EEPROM
>   - DP83867 Gigabit Ethernet PHY
>   - 16 MB SPI Flash
>   - 4 GB eMMC Flash
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

applied all 3 for 4.12 .

One minor change was making the touchscreen node name in patch2 read
	touchscreen at 44

Same rationale as before, nodes should be named after the device-category


Heiko
