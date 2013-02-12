From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Feb 2013 10:24:20 +0100
Subject: [PATCH] arm:
 =?UTF-8?Q?arch=5Ftimer=3A=20add=20missing=20inline=20in?=
 =?UTF-8?Q?=20stub=20function?=
In-Reply-To: <1360624723-10749-1-git-send-email-olof@lixom.net>
References: <1360624723-10749-1-git-send-email-olof@lixom.net>
Message-ID: <93ac4bc370e375a82a10abb3be46afdc@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Feb 2013 15:18:43 -0800, Olof Johansson <olof@lixom.net> wrote:
> Fixes:
> 
> In file included from arch/arm/include/asm/arch_timer.h:10:0,
>                  from arch/arm/mach-shmobile/timer.c:23:
> include/clocksource/arm_arch_timer.h:56:28: warning:
> 'arch_timer_get_timecounter' defined but not used [-Wunused-function]
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Will, Mark, Marc,
> 
> I've applied this on next/virt already since it started spewing pretty
> heavily
> on a lot of defconfig builds. Just posting FYI.

Ah, well spotted. Thanks Olof.

       M.
-- 
Fast, cheap, reliable. Pick two.
