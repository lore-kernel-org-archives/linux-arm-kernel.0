From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 21 Feb 2018 00:26:58 +0900
Subject: [PATCH v2 0/2] add ethernet nodes for UniPhier SoCs
In-Reply-To: <1518600629-14317-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1518600629-14317-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNASu-+GhZ11TPP3bjpJdTRbisSAKDJB6JJBJyQ3uZkA-bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-14 18:30 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> This series adds ethernet nodes for UniPhier Pro4, PXs2, LD6b, LD11, LD20 SoCs
> and the boards.
>
> Changes since v1:
> - move common descriptions to .dtsi files
> - rename labels of the ethernet nodes to "eth"
>
> Kunihiko Hayashi (2):
>   ARM: dts: uniphier: add AVE ethernet node
>   arm64: dts: uniphier: add AVE ethernet node
>

Applied to linux-uniphier. Thanks!


-- 
Best Regards
Masahiro Yamada
