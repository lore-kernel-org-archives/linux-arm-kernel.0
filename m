From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 2 Jul 2015 10:56:47 +0900
Subject: [PATCH] arm64: cpuidle: add __init section marker to
 arm_cpuidle_init
In-Reply-To: <1435800787-696-1-git-send-email-jszhang@marvell.com>
References: <1435800787-696-1-git-send-email-jszhang@marvell.com>
Message-ID: <CAJKOXPdmuP6Tfn1r0o6c7WUT+rLYGqFtJddXsM8x4mkxvH_sPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-02 10:33 GMT+09:00 Jisheng Zhang <jszhang@marvell.com>:
> It is not needed after booting, this patch moves the arm_cpuidle_init()
> function to the __init section.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm64/kernel/cpuidle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks good but I think you can also mark the stub in
arch/arm64/include/asm/cpuidle.h.

Best regards,
Krzysztof
