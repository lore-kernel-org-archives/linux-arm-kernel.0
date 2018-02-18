From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Feb 2018 17:26:23 -0600
Subject: [PATCH 03/10] ARM: dts: mt7623: Remove "cooling-{min|max}-level"
 for CPU nodes
In-Reply-To: <33d7494641d2f89c827e5e09d1143f125c33e784.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <33d7494641d2f89c827e5e09d1143f125c33e784.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <20180218232622.au3cjy7p47xabvv7@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 02:28:03PM +0530, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused properties from the CPU nodes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 4 ----
>  arch/arm/boot/dts/mt7623.dtsi                                  | 2 --
>  2 files changed, 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
