From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 12 Sep 2017 22:33:35 +0900
Subject: [PATCH] pinctrl: uniphier: make arrays static, reduces object
 code size
In-Reply-To: <20170912112124.1143-1-colin.king@canonical.com>
References: <20170912112124.1143-1-colin.king@canonical.com>
Message-ID: <CAK7LNAS+gobUD_rxfSoG8v1jB564=Oa3=jVuVUV7J4odefrTRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-09-12 20:21 GMT+09:00 Colin King <colin.king@canonical.com>:
> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate const arrays on the stack, instead make them
> static.  Makes the object code smaller nearly 1000 bytes. Also
> line break wide lines to avoid checkpatch warnings.
>
> Before:
>    text    data     bss     dec     hex filename
>   13112    1996       0   15108    3b04 pinctrl-uniphier-core.o
>
> After:
>    text    data     bss     dec     hex filename
>   11642    2476       0   14118    3726 pinctrl-uniphier-core.o
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks!

-- 
Best Regards
Masahiro Yamada
