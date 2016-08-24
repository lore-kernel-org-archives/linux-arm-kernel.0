From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 24 Aug 2016 16:24:14 +0100
Subject: [PATCH 2/2] arm64: dts: set UART1 clock frequency to 150MHz
In-Reply-To: <1467965467-28180-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1467965467-28180-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <57BDBC1E.4000501@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jorge,

On 08/07/2016 09:11, Jorge Ramirez-Ortiz wrote:
> Enable support for higher baud rates (up to 3Mbps) in UART1 - required
> for bluetooth transfers.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---

Applied to the hisi-dt-4.9 branch.
Thanks!

Best Regards,
Wei

>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index e92a30c..27be812 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -55,6 +55,8 @@
>  		};
>  
>  		uart1: uart at f7111000 {
> +			assigned-clocks = <&sys_ctrl HI6220_UART1_SRC>;
> +			assigned-clock-rates = <150000000>;
>  			status = "ok";
>  		};
>  
> 
