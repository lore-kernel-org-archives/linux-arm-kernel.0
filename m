From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 16 Aug 2017 11:21:33 +0900
Subject: [PATCH 4/6] arm64: dts: uniphier: use cross-arch include instead
 of symlinks
In-Reply-To: <1502297011-30201-4-git-send-email-yamada.masahiro@socionext.com>
References: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
 <1502297011-30201-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAR6Hm=L1Ph4UfgE2kQrO+RtwF220Zj1P9wbfv4LkJTUtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-08-10 1:43 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> On UniPhier platform, some DTSI files are shared between arm and arm64.
> Recently, inclusion of DT material of different architectures has been
> supported by the build system level.  Use #include <arm/...>, which
> will work without relying on the exact same hierarchy as the kernel.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to linux-uniphier.



-- 
Best Regards
Masahiro Yamada
