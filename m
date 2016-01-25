From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 25 Jan 2016 21:13:11 +0900
Subject: [PATCH] ARM: s3c64xx: use "depends on" instead of "if" after
 prompt
In-Reply-To: <1453722089-23101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453722089-23101-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAJKOXPeyNtBVusQZUKRoBniyWTLMZiAB69KLYkAGxLmy6tfhCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-25 20:41 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> This platform recently moved to multi-platform, so missed the global
> fixup by commit e32465429490 ("ARM: use "depends on" for SoC configs
> instead of "if" after prompt").  Fix it now.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/mach-s3c64xx/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks for the patch. In case it goes through Kukjin's tree:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
