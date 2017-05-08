From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 May 2017 09:48:27 +0530
Subject: [PATCH 5/6] dt-bindings: cpufreq: move Mediatek cpufreq
 dt-bindings document to proper place
In-Reply-To: <1493997974-17699-6-git-send-email-sean.wang@mediatek.com>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
 <1493997974-17699-6-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170508041827.GC17010@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05-05-17, 23:26, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> The old place is Documentation/devicetree/bindings/clock/ that would
> let people hard to find how to use Mediatek cpufreq driver, so moving
> it to the new place as other cpufreq dirvers are done would be better.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/clock/mt8173-cpu-dvfs.txt  | 83 ----------------------
>  .../bindings/cpufreq/cpufreq-mediatek.txt          | 83 ++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 83 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt

Please generate patches with:

git format-patch -C -M --thread=shallow

You would be required to resend this patch at least to let us see what has
changed.

-- 
viresh
