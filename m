From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 05 Sep 2011 14:08:12 +0400
Subject: [PATCH 22/25] OMAP4: PM: Add power domain statistics support
In-Reply-To: <1315144466-9395-23-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-23-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <4E649F8C.4090800@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-09-2011 17:54, Santosh Shilimkar wrote:

> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/omap-mpuss-lowpower.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index 4dd9d0f..0bc7610 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
[...]
> @@ -270,6 +272,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>   	scu_pwrst_prepare(cpu, power_state);
>   	l2x0_pwrst_prepare(cpu, save_state);
>
> +

    Stray newline?

>   	/*
>   	 * Call low level function  with targeted CPU id
>   	 * and its low power state.

WBR, Sergei
