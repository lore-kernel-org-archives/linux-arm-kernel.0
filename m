From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 27 Oct 2016 08:57:31 +0530
Subject: [PATCH 1/2] ARM: dts: uniphier: add CPU clocks and OPP table for
 Pro5 SoC
In-Reply-To: <1477499859-12415-1-git-send-email-yamada.masahiro@socionext.com>
References: <1477499859-12415-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161027032731.GP9162@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-10-16, 01:37, Masahiro Yamada wrote:
> Add a CPU clock to every CPU node and a CPU OPP table to use the
> generic cpufreq driver.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/boot/dts/uniphier-pro5.dtsi | 74 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)

For both patches.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
