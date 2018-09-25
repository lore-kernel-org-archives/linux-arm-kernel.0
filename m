From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Tue, 25 Sep 2018 13:53:56 -0500
Subject: [PATCH] arm64: dts: stratix10: Enable QSPI on SOCFPGA DevKit
In-Reply-To: <1537894165-3524-1-git-send-email-thor.thayer@linux.intel.com>
References: <1537894165-3524-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <7f6f2174-aa2f-2d44-7359-fc827d83c784@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please disregard this patch because it isn't needed.

On 09/25/2018 11:49 AM, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Always enable QSPI the SOCFPGA DevKit since both QSPI and
> SDMMC are available on that platform.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>   arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index 53cf195c2ada..93354c5558df 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -151,6 +151,7 @@
>   };
>   
>   &qspi {
> +	status = "okay";
>   	flash at 0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> 
