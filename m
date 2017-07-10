From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Jul 2017 09:58:52 -0500
Subject: [PATCH v3 2/3] dt-bindings: cpufreq: move MediaTek cpufreq
 dt-bindings document to proper place
In-Reply-To: <77ada8e9c184b4a58463bfe0f2c8b0ef149d2845.1499399121.git.sean.wang@mediatek.com>
References: <cover.1499399121.git.sean.wang@mediatek.com>
 <77ada8e9c184b4a58463bfe0f2c8b0ef149d2845.1499399121.git.sean.wang@mediatek.com>
Message-ID: <20170710145852.pwbpfrv2cyihy5kj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 07, 2017 at 11:56:46AM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> The old place is Documentation/devicetree/bindings/clock/ that would
> let people hard to find how to use MediaTek cpufreq driver, so moving
> it to the appropriate place as other cpufreq drivers done would be
> better.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../bindings/{clock/mt8173-cpu-dvfs.txt => cpufreq/cpufreq-mediatek.txt}  | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{clock/mt8173-cpu-dvfs.txt => cpufreq/cpufreq-mediatek.txt} (100%)

Acked-by: Rob Herring <robh@kernel.org>
