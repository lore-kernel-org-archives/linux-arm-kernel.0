From: robherring2@gmail.com (Rob Herring)
Date: Mon, 28 Sep 2015 12:46:16 -0500
Subject: [PATCH v4 2/5] devicetree: bindings: add new SMP enable method
 Mediatek SoC
In-Reply-To: <1443109140-5406-3-git-send-email-yingjoe.chen@mediatek.com>
References: <1443109140-5406-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443109140-5406-3-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CAL_Jsq+S5fAyCOR-=DOrX5BGYD+FQNqUtEtKYpvx6BX-g01Q_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 10:38 AM, Yingjoe Chen
<yingjoe.chen@mediatek.com> wrote:
> This commit add new cpu enable method "mediatek,mt65xx-smp" and
> "mediatek,mt81xx-tz-smp".
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 91e6e5c..3a07a87 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -195,6 +195,8 @@ nodes to be present and contain the properties described below.
>                             "marvell,armada-380-smp"
>                             "marvell,armada-390-smp"
>                             "marvell,armada-xp-smp"
> +                           "mediatek,mt6589-smp"
> +                           "mediatek,mt81xx-tz-smp"
>                             "qcom,gcc-msm8660"
>                             "qcom,kpss-acc-v1"
>                             "qcom,kpss-acc-v2"
> --
> 1.9.1
>
