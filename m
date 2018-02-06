From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 6 Feb 2018 10:54:40 -0800
Subject: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <20180125163216.29018-2-rnayak@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
Message-ID: <20180206185440.GJ9465@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 25 Jan 08:32 PST 2018, Rajendra Nayak wrote:
> +		spmi_bus: qcom,spmi at c440000 {
[..]
> +		};
> +

While we have the chance, please remove this empty line.

> +	};
> +};

Regards,
Bjorn
