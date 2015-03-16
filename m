From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 16 Mar 2015 09:16:32 +0200
Subject: [PATCH v2 0/2] ARM: devicetree: Remove unused ti,codec property
In-Reply-To: <1426279237-15940-1-git-send-email-marek@goldelico.com>
References: <1426279237-15940-1-git-send-email-marek@goldelico.com>
Message-ID: <55068350.9080500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2015 10:40 PM, Marek Belisko wrote:
> ti,codec in not parsed in omap-twl4030 sound driver. It's not necessary
> to specify this property in DT because ti,twl4030-audio which ti,codec
> was pointing to by phandle is mfd driver and device for ASoC ic created w/o
> any DT property (codec name is hardcoded in ASoC driver).
> 
> Please see reply [1] from Peter Ujfalusi.

All:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Changes from v1:
> - keep ti,codec property in Documentation as optional that the
> existing dtbs do not become noncompliant after the change
> 
> [1]: http://comments.gmane.org/gmane.linux.ports.arm.omap/124273
> 
> Marek Belisko (2):
>   ARM: dts: omap3: Remove all references to ti,codec property
>   Documentation: omap-twl4030: Move ti,codec property to optional
> 
>  Documentation/devicetree/bindings/sound/omap-twl4030.txt | 3 +--
>  arch/arm/boot/dts/omap3-beagle-xm.dts                    | 1 -
>  arch/arm/boot/dts/omap3-beagle.dts                       | 1 -
>  arch/arm/boot/dts/omap3-cm-t3x30.dtsi                    | 1 -
>  arch/arm/boot/dts/omap3-devkit8000.dts                   | 1 -
>  arch/arm/boot/dts/omap3-gta04.dtsi                       | 1 -
>  arch/arm/boot/dts/omap3-igep.dtsi                        | 1 -
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi                  | 1 -
>  arch/arm/boot/dts/omap3-overo-base.dtsi                  | 1 -
>  arch/arm/boot/dts/omap3-tao3530.dtsi                     | 1 -
>  10 files changed, 1 insertion(+), 11 deletions(-)
> 


-- 
P?ter
