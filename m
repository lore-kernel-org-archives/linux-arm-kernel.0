From: thierry.escande@linaro.org (Thierry Escande)
Date: Wed, 27 Jun 2018 11:31:46 +0200
Subject: [PATCH v10 00/14] Krait clocks + Krait CPUfreq
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <a58c2d2c-64d1-7223-dc98-8f749397375d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

On 19/06/2018 15:45, Sricharan R wrote:
> Sricharan R (2):
>    clk: qcom: Add safe switch hook for krait mux clocks
>    dt-bindings: cpufreq: Document operating-points-v2-krait-cpu
> 
> Stephen Boyd (12):
>    ARM: Add Krait L2 register accessor functions
>    clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
>    clk: qcom: Add HFPLL driver
>    dt-bindings: clock: Document qcom,hfpll
>    clk: qcom: Add MSM8960/APQ8064's HFPLLs
>    clk: qcom: Add IPQ806X's HFPLLs
>    clk: qcom: Add support for Krait clocks
>    clk: qcom: Add KPSS ACC/GCC driver
>    dt-bindings: arm: Document qcom,kpss-gcc
>    clk: qcom: Add Krait clock controller driver
>    dt-bindings: clock: Document qcom,krait-cc
>    cpufreq: Add module to register cpufreq on Krait CPUs

Tested on apq8064 (db600c).

Tested-By: Thierry Escande <thierry.escande@linaro.org>

Best regards,
Thierry
