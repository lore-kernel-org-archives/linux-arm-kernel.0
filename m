From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 2 Oct 2015 13:30:57 +0900
Subject: [PATCH v4 0/3] ARM: uniphier: add outer cache support and rework
 SMP operations
In-Reply-To: <1443610906-8608-1-git-send-email-yamada.masahiro@socionext.com>
References: <1443610906-8608-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASLjEFSogG9Ab-Zsrgbr09sxSDaN6Gr0dzQ82VpPUNcmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-30 20:01 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Olof,
>
> Now Linux 4.3-rc1 is out, so I am back to this.
>
> 1/3: add outer cache support
> 2/3: rework SMP operations
> 3/3: add device tree nodes
>
> Because 2/3 highly depends on 1/3, I hope whole of this series
> is applied through ARM-SOC tree.
>
>
> Changes in v4:
>   - Add more detailed comments to explain why no spin lock is needed
>   - Add two examples to the binding document
>
> Changes in v3:
>   - Drop bogus includes
>
> Changes in v2:
>   - Use pr_fmt() to have pr_<level> are automatically prefixed
>   - Re-design to initialize the outer cache earlier in init_IRQ()
>   - Require DT properties such as "cacne-unified", "cache-size",
>     "cache-sets", "cache-size", "cache-line-size".
>   - Follow "next-level-cache" property to search further outer caches
>


I found something to be fixed.

I will send v5.



-- 
Best Regards
Masahiro Yamada
