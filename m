From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 29 May 2015 14:24:20 -0500
Subject: [PATCH 1/2] ARM: socfpga: socrates: enable gpio0/1
In-Reply-To: <1432909983-19821-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1432909983-19821-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <5568BCE4.1060503@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2015 09:33 AM, Steffen Trumtrar wrote:
> Enable the gpio0+1 controller.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
> index a1814b457450..a81f33deaa3a 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
> @@ -36,6 +36,14 @@
>  	status = "okay";
>  };
>  
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> 

Applied.

Thanks,
Dinh
