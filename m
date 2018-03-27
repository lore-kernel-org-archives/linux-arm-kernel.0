From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 28 Mar 2018 01:32:17 +0900
Subject: [PATCH 0/2] add ethernet nodes for UniPhier PXs3 SoC
In-Reply-To: <1522146766-14435-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522146766-14435-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNAStR8jmOUbSUKGcxRi_mZUwJgAwCN__=c6miN8Nfyd2AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-27 19:32 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> This series adds ethernet nodes for UniPhier PXs3 SoC and the board,
> and adds pinctrl groups for second ethernet instances because PXs3 has two
> ethernet instances.
>
> Kunihiko Hayashi (2):
>   ARM: dts: uniphier: add pinctrl groups of ethernet for second instance
>   arm64: dts: uniphier: add ethernet node for PXs3

Applied.  Thanks.


>  arch/arm/boot/dts/uniphier-pinctrl.dtsi            | 10 ++++++
>  .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 22 +++++++++++++
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 36 ++++++++++++++++++++++
>  3 files changed, 68 insertions(+)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
