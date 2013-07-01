From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 1 Jul 2013 22:28:14 +0200
Subject: [PATCH] arm: kirkwood: readynas duo v2: Add GMT G762 Fan
 Controller DT bindings
In-Reply-To: <87sizyuj0t.fsf@natisbad.org>
References: <87sizyuj0t.fsf@natisbad.org>
Message-ID: <20130701222814.36ca395a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Mon, 01 Jul 2013 22:23:14 +0200, Arnaud Ebalard wrote:

> -        regulators {
> -                compatible = "simple-bus";
> -                #address-cells = <1>;
> -                #size-cells = <0>;
> -
> -                usb_power: regulator at 1 {
> -                        compatible = "regulator-fixed";
> -                        reg = <1>;
> -                        regulator-name = "USB 3.0 Power";
> -                        regulator-min-microvolt = <5000000>;
> -                        regulator-max-microvolt = <5000000>;
> -                        enable-active-high;
> -                        regulator-always-on;
> -                        regulator-boot-on;
> -                        gpio = <&gpio1 14 0>;
> -                };
> -        };
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usb_power: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "USB 3.0 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 14 0>;
> +		};
> +	};
>  };

Those white-space changes are not related to the addition of the G762
Device Tree informations.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
