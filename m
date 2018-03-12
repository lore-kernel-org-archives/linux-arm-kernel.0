From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 Mar 2018 15:02:01 +0100
Subject: [PATCH] arm: dts: rk3288: Add missing #sound-dai-cells
In-Reply-To: <20180301202537.30571-3-robh@kernel.org>
References: <20180301202537.30571-3-robh@kernel.org>
Message-ID: <18111539.xZD6rPs4DF@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. M?rz 2018, 21:25:35 CET schrieb Rob Herring:
> dtc now gives the following warning:
> 
> arch/arm/boot/dts/rk3288-tinker.dtb: Warning (sound_dai_property):
> /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node
> /hdmi at ff980000 or bad phandle (referred from sound-dai[0])
> 
> Add the missing #sound-dai-cells property.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

applied as fix for 4.16 (on 2018-03-05 already)

Thanks for the catch
Heiko
