From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 8 Feb 2016 14:45:03 -0800
Subject: [PATCH v3 4/6] qcom: ipq4019: Add basic board/dts support for
 IPQ4019 SoC
In-Reply-To: <1447975173-29485-5-git-send-email-mmcclint@qca.qualcomm.com>
References: <1447975173-29485-1-git-send-email-mmcclint@qca.qualcomm.com>
 <1447975173-29485-5-git-send-email-mmcclint@qca.qualcomm.com>
Message-ID: <20160208224503.GC10791@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19, Matthew McClintock wrote:
> +
> +/ {
> +
> +	clocks {
> +		sleep_clk: sleep_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32768>;
> +			#clock-cells = <0>;
> +		};
> +	};

The timer should be right here in the SoC file.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
