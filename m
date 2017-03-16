From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Mar 2017 17:31:10 +0900
Subject: [PATCH v3 3/3] mtd: nand: Remove unused chip->write_page() hook
In-Reply-To: <1489651362-17077-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1489651362-17077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1489651362-17077-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CAK7LNAQsvwjrp32bZTV95cGRGa7Tq+hEfF89Z9W66aSrb9rLcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-03-16 17:02 GMT+09:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> The last/only user of the chip->write_page() hook (the Atmel NAND
> controller driver) has been reworked and is no longer specifying a custom
> ->write_page() implementation.
> Drop this hook before someone else start abusing it.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
