From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 28 Dec 2015 08:43:40 +0530
Subject: [PATCH v2 3/3] ARM64: dts: mt8173: Add CPU OPP, clock and
 regulator supply properties
In-Reply-To: <1451197318-12418-4-git-send-email-pi-cheng.chen@linaro.org>
References: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
 <1451197318-12418-4-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20151228031340.GD3598@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-12-15, 14:21, Pi-Cheng Chen wrote:
> Add operating-points-v2, clock, and regulator supply properties
> required by mt8173-cpufreq driver to enable it.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
> This patch is based on the patch[1] that adds underlying clock MUX for
> MT8173 which is needed by mt8173-cpufreq driver but not yet picked.
> 
> [1] http://article.gmane.org/gmane.linux.kernel.clk/325
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
