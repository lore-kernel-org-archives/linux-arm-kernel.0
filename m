From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 19 Sep 2013 18:17:38 +0400
Subject: [RFC PATCH 12/15] ARM: dts: omap5: add ocp2scp1 address resource
In-Reply-To: <1379597019-15294-1-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379597019-15294-1-git-send-email-rogerq@ti.com>
Message-ID: <523B0782.7050501@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2013 05:23 PM, Roger Quadros wrote:

> Add OCP2SCP1 module address space.

> CC: Benoit Cousson <bcousson@baylibre.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   arch/arm/boot/dts/omap5.dtsi |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 06aa665..8a88a94 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -663,6 +663,7 @@
>   			#size-cells = <1>;
>   			ranges;
>   			ti,hwmods = "ocp2scp1";
> +			reg = <0x4a080000 0x1f>;

    Are you sure length is not 0x20?

WBR, Sergei
