From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Sun, 17 May 2015 17:28:15 +0900
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: Enable TMU for Exynos
In-Reply-To: <1431850195-9558-7-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
 <1431850195-9558-7-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <CAJKOXPePtxjX0FQKjbN6CegX+1qOa28dZ1kjoiz4UAbNt8zwTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please ignore the patch. I sent this left-over from previous
submission by mistake.

Krzysztof

2015-05-17 17:09 GMT+09:00 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>:
> Enable support for Thermal Monitoring Unit present on Exynos SoCs. This
> allows detection of overheat and handling this gracefully.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
