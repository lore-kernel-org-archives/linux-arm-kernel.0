From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 2 Apr 2018 12:39:57 +0900
Subject: [PATCH 2/2] reset: uniphier: add SATA reset control support and
 change SATA-PHY ID
In-Reply-To: <1522403084-18780-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1522403084-18780-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNAScJ3Z34p6SNbAp3=o_WQMNTi+oNq6YWJZjuNbLYb=4ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-30 18:44 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add reset lines for SATA controller on UniPhier SoCs.
> This adds support for Pro4 and PXs3 in addition to PXs2.
>
> And this changes the ID of the reset line for SATA-PHY on PXs2.
> Since some SoCs have two controller instances with a common PHY, this moves
> the ID of SATA-PHY for consistency.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>






-- 
Best Regards
Masahiro Yamada
