From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 8 Jan 2015 13:28:45 +0100
Subject: [PATCH 2/2] dt-bindings: add mt6592 compatible string for
 mediatek sysirq
In-Reply-To: <1420698191-10878-2-git-send-email-howard.chen@linaro.org>
References: <1420698191-10878-1-git-send-email-howard.chen@linaro.org>
 <1420698191-10878-2-git-send-email-howard.chen@linaro.org>
Message-ID: <CABuKBeLFD4D8MB14o206Bs2t5sqhatsLzhV26rHkFrt5dd8+Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Howard,

2015-01-08 7:23 GMT+01:00 Howard Chen <howard.chen@linaro.org>:
> Signed-off-by: Howard Chen <howard.chen@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt | 1 +
>  1 file changed, 1 insertion(+)

This patch lacks a description of what it does. I added a description
and applied both to my tree. Please remember the next time to add a
description to all patches.

Thanks,
Matthias

>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> index d680b07..4cd6f7b 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> @@ -7,6 +7,7 @@ Required properties:
>  - compatible: should be one of:
>         "mediatek,mt8135-sysirq"
>         "mediatek,mt8127-sysirq"
> +       "mediatek,mt6592-sysirq"
>         "mediatek,mt6589-sysirq"
>         "mediatek,mt6582-sysirq"
>         "mediatek,mt6577-sysirq"
> --
> 1.9.1
>



-- 
motzblog.wordpress.com
