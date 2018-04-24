From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 25 Apr 2018 00:28:45 +0900
Subject: [PATCH 0/4] add additional required properties for UniPhier
 ethernet nodes
In-Reply-To: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNAT2acPfF-mK47Lu3Qc89TrFmSCppLXqSxYiX+eJ=ZKXSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-24 13:46 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add required clocks and their names, resets and their names, and system
> controller properties to fix the activation issues for the ethernet
> controllers implemented on some UniPhier SoCs.
>
> Kunihiko Hayashi (4):
>   ARM: dts: uniphier: add required clocks and resets to Pro4 ethernet
>     node
>   arm64: dts: uniphier: add clock-names and reset-names to ethernet node
>   ARM: dts: uniphier: add syscon-phy-mode property to each ethernet node
>   arm64: dts: uniphier: add syscon-phy-mode property to each ethernet
>     node

All applied to linux-uniphier.  Thanks!







-- 
Best Regards
Masahiro Yamada
