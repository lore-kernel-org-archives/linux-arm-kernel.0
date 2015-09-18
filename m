From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 18 Sep 2015 13:15:40 +0900
Subject: [PATCH v2 0/3] ARM: uniphier: add outer cache support and rework
 SMP operations
In-Reply-To: <1442211992-13177-1-git-send-email-yamada.masahiro@socionext.com>
References: <1442211992-13177-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQP=nf+XRQoJoP6NSd1KZoHoZJMiWf7-pfTJVKSZy3UEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-14 15:26 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
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
> Changes in v2:
>   - Use pr_fmt() to have pr_<level> are automatically prefixed
>   - Re-design to initialize the outer cache earlier in init_IRQ()
>   - Require DT properties such as "cacne-unified", "cache-size",
>     "cache-sets", "cache-size", "cache-line-size".
>   - Follow "next-level-cache" property to search further outer caches
>

This series will be replaced with v3.




-- 
Best Regards
Masahiro Yamada
