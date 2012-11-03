From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 3 Nov 2012 21:24:14 +0530
Subject: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
In-Reply-To: <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50953E26.40906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
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
Whats the intention behind adding OCMRAM ?
Sorry if I missed any comments from the cover letter ?

Regards
Santosh
