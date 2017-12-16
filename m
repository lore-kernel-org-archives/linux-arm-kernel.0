From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 16 Dec 2017 21:11:17 +0100
Subject: [PATCH v2] ARM: dts: add reset property for rk3066a-rayeager emac
 phy
In-Reply-To: <1510134642-18797-1-git-send-email-zyw@rock-chips.com>
References: <1510134642-18797-1-git-send-email-zyw@rock-chips.com>
Message-ID: <9893397.vbQdaeDkgV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Mittwoch, 8. November 2017, 17:50:41 CET schrieb Chris Zhong:
> The ethernet phy of rk3066a-rayeager has a reset pin, it controlled by
> GPIO1_D6, this pin should be pull down then pull up to reset the phy.
> Add a reset-gpios property in phy0, make the phy can be reset when emac
> power on.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
> Changes in v2:
> use a generic property for reset, and this patch follow these 2 pathes
> from Geert Uytterhoeven <geert+renesas@glider.be>
> http://patchwork.ozlabs.org/patch/828499/
> http://patchwork.ozlabs.org/patch/828505/

looks like the phylib-patches were accepted some days ago,
so I've now also applied this patch for 4.16, after fixing the subject
by adding the "rockchip:" to "ARM: dts: rockchip": :-)


Heiko
