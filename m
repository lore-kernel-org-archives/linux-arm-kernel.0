From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Wed, 25 Nov 2015 09:28:00 -0300
Subject: [PATCH 1/3] ARM: dts: lpc4337-ciaa: enable EEPROM memory
In-Reply-To: <1448282225-2635-2-git-send-email-ariel@vanguardiasur.com.ar>
References: <1448282225-2635-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1448282225-2635-2-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <5655A950.3000003@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+To: Joachim)

El 23/11/15 a las 09:37, Ariel D'Alessandro escribi?:
> The CIAA-NXP board has a NXP LPC4337 SoC that includes a 16 KiB
> EEPROM memory.
> 
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> ---
>  arch/arm/boot/dts/lpc4337-ciaa.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
> index 5f500c1..03bdf77 100644
> --- a/arch/arm/boot/dts/lpc4337-ciaa.dts
> +++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
> @@ -155,6 +155,10 @@
>  	};
>  };
>  
> +&eeprom {
> +	status = "okay";
> +};
> +
>  &enet_tx_clk {
>  	clock-frequency = <50000000>;
>  };
> 

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
