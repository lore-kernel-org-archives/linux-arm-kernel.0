From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 10:55:29 -0500
Subject: [PATCH v9 11/15] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
In-Reply-To: <1526901932-9514-12-git-send-email-ilialin@codeaurora.org>
References: <1526901932-9514-1-git-send-email-ilialin@codeaurora.org>
 <1526901932-9514-12-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180522155529.GA30543@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 02:25:28PM +0300, Ilia Lin wrote:
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> This change adds documentation for the DT bindings.
> The "operating-points-v2-kryo-cpu" DT extends the "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-supported-hw: A single 32 bit bitmap value,
>   representing compatible HW:
> 			0:	MSM8996 V3, speedbin 0
> 			1:	MSM8996 V3, speedbin 1
> 			2:	MSM8996 V3, speedbin 2
> 			3:	unused
> 			4:	MSM8996 SG, speedbin 0
> 			5:	MSM8996 SG, speedbin 1
> 			6:	MSM8996 SG, speedbin 2
> 			7-31:	unused
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Please add acks/reviewed-bys when posting new versions.

Rob
