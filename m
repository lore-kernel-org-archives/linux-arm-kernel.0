From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Fri, 26 Oct 2018 15:14:35 -0500
Subject: [PATCH] ARM: dts: socfpga: Fix SDRAM node address for Arria10
In-Reply-To: <1537888870-357-1-git-send-email-thor.thayer@linux.intel.com>
References: <1537888870-357-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <0e965db7-78e7-afba-2b6e-0ccd1b73ae36@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle ping.

On 9/25/18 10:21 AM, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The address in the SDRAM node was incorrect. Fix this to agree with the
> correct address and to match the reg definition block.
> 
> Cc: stable at vger.kernel.org
> Fixes: 54b4a8f57848b("arm: socfpga: dts: Add Arria10 SDRAM EDAC DTS support")
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>   arch/arm/boot/dts/socfpga_arria10.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
> index 791ca15c799e..bd1985694bca 100644
> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
> @@ -601,7 +601,7 @@
>   			status = "disabled";
>   		};
>   
> -		sdr: sdr at ffc25000 {
> +		sdr: sdr at ffcfb100 {
>   			compatible = "altr,sdr-ctl", "syscon";
>   			reg = <0xffcfb100 0x80>;
>   		};
> 
