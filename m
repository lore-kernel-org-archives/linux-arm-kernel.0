From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 06 Nov 2014 18:31:58 +0100
Subject: [PATCH] documentation: pinctrl bindings: Fix trivial typo
 'abitrary'
In-Reply-To: <1415288331-785-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1415288331-785-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <545BB08E.8070607@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.11.2014 um 16:38 schrieb Soren Brinkmann:
> A misspelled 'arbitrary' propagated to quite a few locations in the DT
> binding documentation for pin-controllers. Fixing by:
>   git grep abitrary | cut -f1 -d: | xargs sed -i 's/abitrary/arbitrary/'
> 
> Reported-by: Andreas F?rber <afaerber@suse.de>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/img,tz1090-pdc-pinctrl.txt | 2 +-
>  Documentation/devicetree/bindings/pinctrl/img,tz1090-pinctrl.txt     | 2 +-
>  Documentation/devicetree/bindings/pinctrl/lantiq,falcon-pinumx.txt   | 2 +-
>  Documentation/devicetree/bindings/pinctrl/lantiq,xway-pinumx.txt     | 2 +-
>  Documentation/devicetree/bindings/pinctrl/nvidia,tegra20-pinmux.txt  | 2 +-
>  Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt           | 2 +-
>  Documentation/devicetree/bindings/pinctrl/pinctrl_spear.txt          | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt   | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt   | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt   | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt   | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt   | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
