From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 7 Mar 2017 05:26:36 +0900
Subject: [PATCH 0/3] arm,arm64: dts: uniphier: remove skeleton.dtsi
 inclusion and fix warnings
In-Reply-To: <1488085449-28922-1-git-send-email-yamada.masahiro@socionext.com>
References: <1488085449-28922-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAT0JNuSAVvRJKOpjm=+y8eMWyJSPs_uOoRLFa1OvYhXvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-26 14:04 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>   - The inclusion of skeleton.dtsi is deprecated.
>     Specify #address-cells and #size-cells explicitly
>
>   - If built with W=1, many warnings are displayed.  Fix them.
>
>
> Masahiro Yamada (3):
>   ARM: dts: uniphier: remove skeleton.dtsi inclusion
>   ARM: dts: uniphier: fix no unit name warnings
>   arm64: dts: uniphier: fix no unit name warnings


Series, applied to linux-uniphier.






-- 
Best Regards
Masahiro Yamada
