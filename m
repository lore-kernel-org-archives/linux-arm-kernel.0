From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 27 Jan 2016 22:50:17 +0900
Subject: [PATCH 15/15] Revert "of/platform: export
 of_default_bus_match_table"
In-Reply-To: <1453868872-26300-16-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-16-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <CAK7LNATdqvV6pUsog7uN0RYS1RW6LDoBxaZ0dkOf0nf=T1RLWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-27 13:27 GMT+09:00 Kefeng Wang <wangkefeng.wang@huawei.com>:
> This reverts commit b80443c2211c7daaabd20fbbe9e7beb3fa3408e0.
>
> After covering to use helper of_platform_default_populate() to populate
> the default bus, no need to export of_default_bus_match_table anymore.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
