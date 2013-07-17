From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 17 Jul 2013 10:48:57 +0530
Subject: [PATCH RFC v2 14/14] ARM: debug: move Spear debug to generic
 PL01x code
In-Reply-To: <E1Uz8PB-00048R-F3@rmk-PC.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <E1Uz8PB-00048R-F3@rmk-PC.arm.linux.org.uk>
Message-ID: <CAOh2x==PCWa_eOK1S5oy+B-tbwin2ceeb92-ihJ6J_XmC2irUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 10:17 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> The Spear debug code is a copy of the PL01x debugging code, so rather
> than have this pointless code duplication, lets just use the standard
> implementation instead.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig.debug                         |    7 ++++
>  arch/arm/mach-spear/include/mach/debug-macro.S |   36 ------------------------
>  arch/arm/mach-spear/include/mach/spear.h       |    2 -
>  3 files changed, 7 insertions(+), 38 deletions(-)
>  delete mode 100644 arch/arm/mach-spear/include/mach/debug-macro.S

s/Spear/SPEAr

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
