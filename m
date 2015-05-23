From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 23 May 2015 20:41:29 +0900
Subject: [PATCH] ARM: exynos_defconfig: savedefconfig
In-Reply-To: <555FF55E.7020701@kernel.org>
References: <555FF55E.7020701@kernel.org>
Message-ID: <CAJKOXPcaK8B3oJw=qaJhgHFH3XfYNmmkGa3MFEbdBnsokZyhDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-23 12:34 GMT+09:00 Kukjin Kim <kgene@kernel.org>:
> This patch does 'savedefconfig' for exynos_defconfig to remove useless
> configs and check its dependencies. Sometimes some configs could be
> ignored because of the dependencies even they are enabled in defconfig
> file manually. So checking the dependencies would be better.
>
> Signed-off-by: Kukjin Kim <kgene@kernel.org>

Generated autoconf.h is almost the same as previously, so:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
