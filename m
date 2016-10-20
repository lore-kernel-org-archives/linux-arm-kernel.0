From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 20 Oct 2016 10:17:01 +0530
Subject: [PATCH v3 1/2] arm64: dts: uniphier: add CPU clock and OPP table
 for LD11 SoC
In-Reply-To: <1476938647-26376-1-git-send-email-yamada.masahiro@socionext.com>
References: <1476938647-26376-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161020044701.GJ11766@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-10-16, 13:44, Masahiro Yamada wrote:
> Add a CPU clock to every CPU node and a CPU OPP table to use the
> generic cpufreq driver.
> 
> Note:
> clock-latency-ns (300ns) was calculated based on the CPU-gear switch
> sequencer spec; it takes 12 clock cycles on the sequencer running
> at 50 MHz, plus a bit additional latency.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Match the node name to the opp-hz property.

For both the patches ..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
