From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri, 10 Jun 2016 15:36:03 +0300
Subject: [PATCH 1/2] ARM: dts: apq8064: rename db600c to SD_600eval
In-Reply-To: <1465551298-21457-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1465551298-21457-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <575AB433.3060006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini,

On 06/10/2016 12:34 PM, Srinivas Kandagatla wrote:
> This board has been renamed recently and announced at
> https://eragon.einfochips.com/products/sd-600eval.html
> 
> So rename this board files so that it reflects actual product in market.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                         |   2 +-
>  .../boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi   |  52 ---
>  arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts    | 349 ---------------------
>  .../dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi    |  52 +++
>  .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 349 +++++++++++++++++++++
>  5 files changed, 402 insertions(+), 402 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
>  delete mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
>  create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi
>  create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
> 

If you use git format-patch -M, we will see and track the renamed files
easier than deleting and adding the files.

BR,
Georgi
