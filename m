From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 06 Nov 2018 12:31:01 +0100
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add Gru Scarlet devicetrees
In-Reply-To: <20181101123639.15560-2-heiko@sntech.de>
References: <20181101123639.15560-1-heiko@sntech.de>
 <20181101123639.15560-2-heiko@sntech.de>
Message-ID: <55055985.ydjp5xQfPl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. November 2018, 13:36:39 CET schrieb Heiko Stuebner:
> Gru-Scarlet is a tablet device using ChomeOS, dual-dsi display
> and Wacom touchscreen with stylus.
> 
> There exist two variants in the market using different displays
> that are differentiated via their sku-id.
> The bootloader on them also determines the correct devicetree to
> load via the sku-id.
> 
> So add a common scarlet dtsi and two minimal board devicetrees
> for the two display variants.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

looks like I already applied patch1 in time for 4.20
(and forgot about it), but have now also applied this patch2
for 4.21 with Rob's review.
