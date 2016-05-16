From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 16 May 2016 00:29:14 +0000
Subject: [PATCH 00/23] ARM/arm64: dts: renesas: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
Message-ID: <87wpmuetqv.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Geert

> This patch series fixes the new warnings related to Renesas arm32/arm64
> DTSes that can be seen in -next using "make W=1 dtbs", courtesy of
> commit b993734718c01064 ("scripts/dtc: Update to upstream version
> 53bf130b1cdd") in Rob herring's for-next branch. They're all of the
> form:
> 
>     Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit name, but no reg property
>     Warning (unit_address_vs_reg): Node /cache-controller has a reg or ranges property, but no unit name
>     Warning (unit_address_vs_reg): Node /clocks at e0110000/iic0_sclkdiv has a reg or ranges property, but no unit name
>     Warning (unit_address_vs_reg): Node /i2c at 2 has a unit name, but no reg property
>     Warning (unit_address_vs_reg): Node /keyboard/button at 1 has a unit name, but no reg property
>     Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>     Warning (unit_address_vs_reg): Node /pfc at e0140200/serial at e1030000 has a unit name, but no reg property
>     Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
>     Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 0 has a unit name, but no reg property
>     Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,dvc/dvc at 0 has a unit name, but no reg property
>     Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,mix/mix at 0 has a unit name, but no reg property
>     Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 0 has a unit name, but no reg property
>     Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 0 has a unit name, but no reg property
(snip)
> Morimoto-san: If this is accepted, the examples in
> Documentation/devicetree/bindings/sound/renesas,rsnd.txt should be
> updated, too.

Thanks. will do.

Best regards
---
Kuninori Morimoto
