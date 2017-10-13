From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 13 Oct 2017 09:51:51 +0100
Subject: [PATCH] arm64: dts: hisilicon: Standardize Poplar GPIO line names
In-Reply-To: <20171002142129.13102-1-linus.walleij@linaro.org>
References: <20171002142129.13102-1-linus.walleij@linaro.org>
Message-ID: <59E07EA7.9000501@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 2017/10/2 15:21, Linus Walleij wrote:
> The hi6220-HiKey board started to name GPIO lines for
> 96boards, using just the plain names "GPIO-A" etc from the
> 96boards specification.
> 
> Poplar started to use an arbitrary "LS-GPIO-A" (etc) prefix
> that is not part of the 96boards specification.
> 
> As the former notation arrived first, and we need
> consistency among 96board, rectify the Poplar board to use
> this too. This is important for userspace that wants to
> look up GPIO names from these strings.
> 
> Cc: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Cc: Alex Elder <elder@linaro.org>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Applied to hisilicon dt tree.
Thanks!

BR,
Wei

>  arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> index b9142871d6fe..a6fd13389f8d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> @@ -78,17 +78,17 @@
>  
>  &gpio1 {
>  	status = "okay";
> -	gpio-line-names = "LS-GPIO-E",	"",
> +	gpio-line-names = "GPIO-E",	"",
>  			  "",		"",
> -			  "",		"LS-GPIO-F",
> -			  "",		"LS-GPIO-J";
> +			  "",		"GPIO-F",
> +			  "",		"GPIO-J";
>  };
>  
>  &gpio2 {
>  	status = "okay";
> -	gpio-line-names = "LS-GPIO-H",	"LS-GPIO-I",
> -			  "LS-GPIO-L",	"LS-GPIO-G",
> -			  "LS-GPIO-K",	"",
> +	gpio-line-names = "GPIO-H",	"GPIO-I",
> +			  "GPIO-L",	"GPIO-G",
> +			  "GPIO-K",	"",
>  			  "",		"";
>  };
>  
> @@ -96,15 +96,15 @@
>  	status = "okay";
>  	gpio-line-names = "",		"",
>  			  "",		"",
> -			  "LS-GPIO-C",	"",
> -			  "",		"LS-GPIO-B";
> +			  "GPIO-C",	"",
> +			  "",		"GPIO-B";
>  };
>  
>  &gpio4 {
>  	status = "okay";
>  	gpio-line-names = "",		"",
>  			  "",		"",
> -			  "",		"LS-GPIO-D",
> +			  "",		"GPIO-D",
>  			  "",		"";
>  };
>  
> @@ -112,7 +112,7 @@
>  	status = "okay";
>  	gpio-line-names = "",		"USER-LED-1",
>  			  "USER-LED-2",	"",
> -			  "",		"LS-GPIO-A",
> +			  "",		"GPIO-A",
>  			  "",		"";
>  };
>  
> 
