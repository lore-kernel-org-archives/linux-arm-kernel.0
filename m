From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 28 Jun 2017 21:43:21 -0700
Subject: [PATCH v6 5/6] arm64: dts: Add ipq8074 SoC and HK01 board support
In-Reply-To: <1497001319-30353-6-git-send-email-varada@codeaurora.org>
References: <1497001319-30353-1-git-send-email-varada@codeaurora.org>
 <1497001319-30353-6-git-send-email-varada@codeaurora.org>
Message-ID: <20170629044321.GU18666@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 09 Jun 02:41 PDT 2017, Varadarajan Narayanan wrote:
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
[..]
> +
> +	chosen {
> +		bootargs = "root=/dev/ram0 rw init=/init";

As far as I know you can omit both root= and init= from this.

> +		stdout-path = "serial0";
> +	};
> +

Apart from that,

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
