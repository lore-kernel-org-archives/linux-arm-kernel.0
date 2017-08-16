From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 16 Aug 2017 11:50:43 +0900
Subject: [PATCH 5/6] ARM: dts: uniphier: add Denali NAND controller node
In-Reply-To: <1502297011-30201-5-git-send-email-yamada.masahiro@socionext.com>
References: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
 <1502297011-30201-5-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQVQeh0=kpALRVos42vacLNcgmUbEPRngMYroMq8P71cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-08-10 1:43 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Add NAND controller node to LD4, Pro4, sLD8, Pro5, and PXs2.
> Set up pinctrl to enable 2 chip select lines except Pro4.  The CS1
> for Pro4 is multiplexed with other peripherals such as UART2, so
> I did not enable it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

With some compatibles fixed, applied to linux-uniphier.

-- 
Best Regards
Masahiro Yamada
