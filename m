From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 18 Sep 2017 21:10:23 +0900
Subject: [RESEND PATCH v4 0/2] add thermal nodes for UniPhier SoCs
In-Reply-To: <1504508317-12076-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1504508317-12076-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNATX2bNGDTgEHrv9gjah_4ZXrTjRg45hPVOze774RB1_wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-09-04 15:58 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> This series adds thermal nodes for UniPhier PXs2 and LD20 SoCs.
>
> Resending the patches to apply the missing comments,
> please ignore previous v4.
>
> Changes since v3:
> - use the dt-bindings header to replace the limit values with THERMAL_NO_LIMIT
> - add the calibration value to uniphier-pxs2.dtsi
> - move the calibration value to uniphier-ld20.dtsi
>
> Changes since v2:
> - add the calibration value to device tree for LD20 reference board
>
> Changes since v1:
> - separate from driver's patchset[1]
> - add cooling-maps nodes on the device tree
> - fix an interrupt trigger to set 'level-triggered' according to
>   hardware specification
> - bring up threshold temperature for LD20 according to the spec sheet
> - add cpuN labels for reference in cooling-device property on PXs2 dts
>
> [1] https://lkml.org/lkml/2017/6/28/170
>
> Kunihiko Hayashi (2):
>   ARM: dts: uniphier: add nodes of thermal monitor and thermal zone for
>     PXs2
>   arm64: dts: uniphier: add nodes of thermal monitor and thermal zone
>     for LD20
>
>  arch/arm/boot/dts/uniphier-pxs2.dtsi             | 47 ++++++++++++++++++++++--
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 45 +++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 4 deletions(-)
>

Series, applied to linux-uniphier.  Thanks!

-- 
Best Regards
Masahiro Yamada
