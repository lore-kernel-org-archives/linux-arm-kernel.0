From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 14 May 2012 09:03:14 +0530
Subject: [PATCH] ARM: SPEAr600: Fix timer interrupt definition in
 spear600.dtsi
In-Reply-To: <1336725661-29271-1-git-send-email-sr@denx.de>
References: <1336725661-29271-1-git-send-email-sr@denx.de>
Message-ID: <4FB07CFA.4050108@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/11/2012 2:11 PM, Stefan Roese wrote:
> diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
> index 089f0a4..a3c36e4 100644
> --- a/arch/arm/boot/dts/spear600.dtsi
> +++ b/arch/arm/boot/dts/spear600.dtsi
> @@ -181,6 +181,7 @@
>  			timer at f0000000 {
>  				compatible = "st,spear-timer";
>  				reg = <0xf0000000 0x400>;
> +				interrupt-parent = <&vic0>;
>  				interrupts = <16>;
>  			};
>  		};

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
