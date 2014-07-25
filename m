From: dianders@chromium.org (Doug Anderson)
Date: Thu, 24 Jul 2014 20:50:57 -0700
Subject: [PATCH v2 5/7] ARM: rockchip: enable support for RK3288 SoCs
In-Reply-To: <4818373.bUUc3kJllt@diego>
References: <4868343.UFgjaXesOn@diego>
	<4818373.bUUc3kJllt@diego>
Message-ID: <CAD=FV=X3Fxeh7T7Hy0X3ptMjMW0Gcua0aFV4iVCYT8yG0yD44g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Thu, Jul 17, 2014 at 5:21 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Enable HAVE_ARM_ARCH_TIMER and add a rockchip,rk3288 compatible.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/mach-rockchip/Kconfig    | 1 +
>  arch/arm/mach-rockchip/rockchip.c | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
