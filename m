From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Nov 2015 12:41:24 -0800
Subject: [PATCH RFC 07/27] PM / Domains: Read domain residency from DT
In-Reply-To: <1447799871-56374-8-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-8-git-send-email-lina.iyer@linaro.org>
Message-ID: <20151124204124.GB25963@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17, Lina Iyer wrote:
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index ecfaf44..d71da29 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -67,6 +67,13 @@ have the following properties -
>  		If omitted, this is assumed to be equal to:
>  			entry-latency-us + exit-latency-us
>  
> +	- residency-us:
> +		Usage: Optional
> +		Value type: <prop-encoded-array>

Is it an array or just a single u32? Some example would be good
to add.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
