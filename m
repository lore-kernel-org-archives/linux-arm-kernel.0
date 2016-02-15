From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 15 Feb 2016 08:02:20 +0100
Subject: [PATCH] ARM: drop unused Makefile.boot of Multiplatform SoCs
In-Reply-To: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
 (Masahiro Yamada's message of "Sat, 6 Feb 2016 02:36:48 +0900")
References: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <m3r3gebgn7.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> The variable "MACHINE" is empty if CONFIG_ARCH_MULTIPLATFORM=y,
> so these Makefile.boot files are never included.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/mach-cns3xxx/Makefile.boot    | 3 ---

Acked-by: Krzysztof Ha?asa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
