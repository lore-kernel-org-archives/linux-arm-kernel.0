From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 9 Aug 2017 19:56:05 +0530
Subject: [PATCH 1/2] cpufreq: mediatek: add cleanups with the more
 generic naming
In-Reply-To: <c658e5aa68d26c645a8ecd58da69576c9fe237c5.1502272372.git.sean.wang@mediatek.com>
References: <cover.1502272372.git.sean.wang@mediatek.com>
 <c658e5aa68d26c645a8ecd58da69576c9fe237c5.1502272372.git.sean.wang@mediatek.com>
Message-ID: <20170809142605.GC29383@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-08-17, 18:12, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Since more MediaTek SoCs can be supported with the cpufreq driver and not
> limited to MT8173, a couple of cleanups are done here with renaming those
> functions and related structures with "mtk" instead of "mt8173".
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
