From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 6 Jul 2016 09:44:11 +0200
Subject: [PATCH] arm64: dts: exynos: Modify the voltage range for BUCK2
 for exynos7
In-Reply-To: <1467750537-13911-1-git-send-email-a.kesavan@samsung.com>
References: <1467750537-13911-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAJKOXPfWanrkNvSRz384UNga1QUWuVS8rHvYbda9_io06RkeQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2016 at 10:28 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> Change the BUCK2 (vdd_atlas) voltage range to '500 - 1200mv' since
> CPU DVFS requires it.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks, applied.

Best regards,
Krzysztof
