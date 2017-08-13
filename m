From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 13 Aug 2017 23:23:21 +0900
Subject: [PATCH v2 3/3] reset: uniphier: add analog amplifiers reset
 control
In-Reply-To: <20170813090043.3828-3-suzuki.katsuhiro@socionext.com>
References: <20170813090043.3828-1-suzuki.katsuhiro@socionext.com>
 <20170813090043.3828-3-suzuki.katsuhiro@socionext.com>
Message-ID: <CAK7LNAT1UYq8whR_LRwQQeGQ_rxNB33xMcO7+LqELos_iagt6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-08-13 18:00 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> Add a reset line for analog signal amplifier core (ADAMV) on
> UniPhier LD11/LD20 SoCs.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
>
> ---
>
> Changes for v2:
>   - ID changes to 0 because ADAMV reset controller independents
>     from other reset controllers.
>   - Add DT-binding documents.


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks!

-- 
Best Regards
Masahiro Yamada
