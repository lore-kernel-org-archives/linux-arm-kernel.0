From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 2 Mar 2017 16:37:02 +0530
Subject: [PATCH 2/2 v2] cpufreq: mediatek: Add support for MT8176 and
 MT817x
In-Reply-To: <20170302110345.184924-2-djkurtz@chromium.org>
References: <20170302110345.184924-1-djkurtz@chromium.org>
 <20170302110345.184924-2-djkurtz@chromium.org>
Message-ID: <20170302110702.GD13760@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-03-17, 19:03, Daniel Kurtz wrote:
> The Mediatek MT8173 is just one of several SOCs from the same MT817x family,
> including the 6-core (4-little/2-big) MT8176.
> 
> The mt8173-cpufreq driver supports all of these SOCs, however, machines
> using them may use a different machine compatible.
> 
> Since this driver checks explicitly for the machine compatible string, add
> support for the whole family.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
> This patch is based on the compatibles added by the MT8176 series:
> 
>  https://patchwork.kernel.org/patch/9573209/
>  https://patchwork.kernel.org/patch/9573213/
> 
> v2:
>  - use of_match_node (Thanks, Viresh!)
> 
>  drivers/cpufreq/mt8173-cpufreq.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
