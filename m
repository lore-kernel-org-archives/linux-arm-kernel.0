From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 15 May 2018 09:34:39 +0530
Subject: [PATCH v6 11/14] dt: qcom: Add SAW regulator for 8x96 CPUs
In-Reply-To: <1526303520-5843-12-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
 <1526303520-5843-12-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180515040439.3kt6dudim2uroumd@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-05-18, 16:11, Ilia Lin wrote:
> 1. Add syscon node for the SAW CPU registers
> 2. Add SAW regulators gang definition for s8-s11
> 3. Add voltages to the OPP tables
> 4. Add the s11 SAW regulator as CPU regulator
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 75 +++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
