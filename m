From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 20 Jan 2017 15:30:21 +0000
Subject: [PATCH v14 5/5] arm64: dt: hikey: Add optee node
In-Reply-To: <1484744296-30003-6-git-send-email-jens.wiklander@linaro.org>
References: <1484744296-30003-1-git-send-email-jens.wiklander@linaro.org>
 <1484744296-30003-6-git-send-email-jens.wiklander@linaro.org>
Message-ID: <58822D0D.4000803@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

On 2017/1/18 12:58, Jens Wiklander wrote:
> From: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks!
Fine to me.
Acked-by: Wei Xu <xuwei5@hisilicon.com>

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index dba3c131c62c..89c15399bec2 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -406,6 +406,13 @@
>  			};
>  		};
>  	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
>  };
>  
>  &uart2 {
> 
