From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 15 May 2018 09:39:50 +0530
Subject: [PATCH v6 13/14] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
In-Reply-To: <1526303520-5843-14-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
 <1526303520-5843-14-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180515040950.otlennfyfvuujyfc@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-05-18, 16:11, Ilia Lin wrote:
> In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
> that have KRYO processors, the CPU ferequencies subset and voltage value
> of each OPP varies based on the silicon variant in use.
> Qualcomm Technologies, Inc. Process Voltage Scaling Tables
> defines the voltage and frequency value based on the msm-id in SMEM
> and speedbin blown in the efuse combination.
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> This change adds documentation.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
>  1 file changed, 680 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
