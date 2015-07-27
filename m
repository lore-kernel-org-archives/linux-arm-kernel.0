From: agross@codeaurora.org (Andy Gross)
Date: Mon, 27 Jul 2015 15:36:45 -0500
Subject: [PATCH v1 3/7] ARM: dts: qs600: Add real regulators to sdcc
In-Reply-To: <1438005020-16306-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438005020-16306-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150727203645.GC12739@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 02:50:20PM +0100, Srinivas Kandagatla wrote:

<snip>

>  			/* WLAN */
>  			sdcc4: sdcc at 121c0000 {
>  				status = "okay";
> +				vmmc-supply = <&v3p3_fixed>;
> +				vqmmc-supply = <&v3p3_fixed>;
> +				mmc-pwrseq = <&sdcc4_pwrseq>;

Where is sdcc4_pwrseq defined?


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
