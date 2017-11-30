From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 30 Nov 2017 21:09:21 +0900
Subject: [PATCH 1/3] kbuild: add clang-version.sh
In-Reply-To: <CAKwvOdndEfdXuRCeSsr04pAt0d0tE_z72DUYc2Z9LCnXAQc4Hw@mail.gmail.com>
References: <20171129000011.55235-1-samitolvanen@google.com>
 <20171129000011.55235-2-samitolvanen@google.com>
 <CAKwvOdndEfdXuRCeSsr04pAt0d0tE_z72DUYc2Z9LCnXAQc4Hw@mail.gmail.com>
Message-ID: <CAK7LNATDYV0p8KvA6dL+7or3osNNBBwO2CjUaFz2UV_2iOYADQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-11-30 2:39 GMT+09:00 Nick Desaulniers <ndesaulniers@google.com>:
> +# clang-version [-p] clang-command
> +#
> +# Prints the compiler version of `command' in a canonical 4-digit form
>
> small nit: `command` should be `clang-command`, but its just a comment
> (maybe the maintainer can make that change when/if applying).


I would be happy to fix it up locally if there were no other issue.


> The conditional at the end to see if $with_patchlevel using "x" is
> odd, but this is what scripts/gcc-version.sh does and this patch does
> work as expected.
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
