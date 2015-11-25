From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Wed, 25 Nov 2015 09:28:39 -0300
Subject: [PATCH 2/3] ARM: dts: lpc4337-ciaa: enable SCT-PWM
In-Reply-To: <1448282225-2635-3-git-send-email-ariel@vanguardiasur.com.ar>
References: <1448282225-2635-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1448282225-2635-3-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <5655A977.1040408@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+To: Joachim)

El 23/11/15 a las 09:37, Ariel D'Alessandro escribi?:
> Enable the PWM based on the State Configurable Timer (SCT) included in
> the LPC4337 SoC of the CIAA-NXP board.
> 
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> ---
>  arch/arm/boot/dts/lpc4337-ciaa.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
> index 03bdf77..1a23589 100644
> --- a/arch/arm/boot/dts/lpc4337-ciaa.dts
> +++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
> @@ -170,6 +170,10 @@
>  	pinctrl-0 = <&enet_rmii_pins>;
>  };
>  
> +&sct_pwm {
> +	status = "okay";
> +};
> +
>  &ssp1 {
>  	status = "okay";
>  	pinctrl-names = "default";
> 

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
