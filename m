From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 6 Mar 2018 10:33:45 +0900
Subject: [PATCH] arm64: dts: uniphier: add fixed regulators for audio codec
In-Reply-To: <20180228093247.29648-1-suzuki.katsuhiro@socionext.com>
References: <20180228093247.29648-1-suzuki.katsuhiro@socionext.com>
Message-ID: <CAK7LNASTRCy=MOVVAJhobnZ4SLvdWoy+wR=tovb-bLJLRhxs9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-28 18:32 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch adds regulators that have fixed voltage for audio codec
> on UniPhier LD11/20 Global boards. This patch fixes warnings about
> TAS57xx audio codec such as "tas571x 0-001b: 0-001b supply AVDD
> not found, using dummy regulator".
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

Applied to linux-uniphier.  Thanks!



-- 
Best Regards
Masahiro Yamada
