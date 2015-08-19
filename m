From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 19 Aug 2015 14:50:25 +0900
Subject: [PATCH] ARM: dts: UniPhier: fix PPI interrupt CPU mask of timer
 nodes
In-Reply-To: <1439963147-2592-1-git-send-email-yamada.masahiro@socionext.com>
References: <1439963147-2592-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNATCmyO=Ys_cVJ3sox7Dn+qfKAMyxnBAEXVgZN58ApkDEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-19 14:45 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> This SoC is integrated with 4 Cortex-A9 cores.  The GIC bindings
> says that the bits[15:8] of the 3rd cell of the interrupts property
> represents PPI interrupt CPU mask.  Because the timer interrupts are
> wired to all of the 4 cores, bits[15:8] should be set to 0xf.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

This has been superseded by v2.

-- 
Best Regards
Masahiro Yamada
