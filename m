From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Sat, 03 Nov 2012 13:16:06 +0100
Subject: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
In-Reply-To: <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50950B06.8010800@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Even simple patches need a simple changelog.

Kevin

>   arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index bb31bff..e2cbf24 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -210,5 +210,16 @@
>   			interrupt-parent = <&intc>;
>   			interrupts = <91>;
>   		};
> +
> +		ocmcram: ocmcram at 40300000 {
> +			compatible = "ti,ocmcram";
> +			ti,hwmods = "ocmcram";
> +			ti,no_idle_on_suspend;
> +		};
> +
> +		wkup_m3: wkup_m3 at 44d00000 {
> +			compatible = "ti,wkup_m3";
> +			ti,hwmods = "wkup_m3";
> +		};
>   	};
>   };
>
