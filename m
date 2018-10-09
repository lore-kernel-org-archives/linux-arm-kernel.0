From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 9 Oct 2018 10:19:45 +0200
Subject: [PATCH 3/7] clocksource: Change CPU hotplug priority of
 exynos_mct driver
In-Reply-To: <20181008125009.3721-4-m.szyprowski@samsung.com>
References: <CGME20181008125047eucas1p1bbd0c4759612b6df8fbe25f759e03130@eucas1p1.samsung.com>
 <20181008125009.3721-1-m.szyprowski@samsung.com>
 <20181008125009.3721-4-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPc5uB0cnwvcN5SinmajKgb=O-bGgrmRHCThNndFwLGeyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Oct 2018 at 14:50, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Exynos Multi-Core Timer driver (exynos_mct) must be started before
> ARM Architected Timers (arch_timer), because both timers share common
> hardware block and turning on MCT is needed to get ARM Architected
> Timer working properly.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/cpuhotplug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
