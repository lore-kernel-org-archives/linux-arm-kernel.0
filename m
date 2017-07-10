From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Jul 2017 10:02:38 -0500
Subject: [PATCH v3 3/3] dt-bindings: cpufreq: enhance MediaTek cpufreq
 dt-binding document
In-Reply-To: <74cfd6007e87f0fcca401b31be17dbf98808d001.1499399121.git.sean.wang@mediatek.com>
References: <cover.1499399121.git.sean.wang@mediatek.com>
 <74cfd6007e87f0fcca401b31be17dbf98808d001.1499399121.git.sean.wang@mediatek.com>
Message-ID: <20170710150238.aie46rtl4anadofg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 07, 2017 at 11:56:47AM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Update binding document with adding operating-points-v2 as the required
> property and the cooling level as the optional properties and adding more
> examples guiding people how to use MediaTek cpufreq driver for MediaTek
> SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek.txt          | 170 ++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
