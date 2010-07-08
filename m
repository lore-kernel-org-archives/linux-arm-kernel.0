From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Jul 2010 20:05:30 +0900
Subject: [PATCH] s5pc110: Reduce the iodesc length of systimer
In-Reply-To: <20100708023647.GA8320@july>
References: <20100708023647.GA8320@july>
Message-ID: <020201cb1e8d$7d90ba50$78b22ef0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> It's enough to use 4KiB.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Where is submitter(kmpark at infradead.org)'s Signed-off-by?
I know submitter and author in here are same...but e-mail.
So added 'From' in your patch.

It would be helpful to me if you use same e-mail in a patch.

Also, the commit message needs to be more descriptive.

> ---
> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> index 411a4a9..07b86d2 100644
> --- a/arch/arm/mach-s5pv210/cpu.c
> +++ b/arch/arm/mach-s5pv210/cpu.c
> @@ -41,7 +41,7 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
>  	{
>  		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
>  		.pfn		= __phys_to_pfn(S5PV210_PA_SYSTIMER),
> -		.length		= SZ_1M,
> +		.length		= SZ_4K,
>  		.type		= MT_DEVICE,
>  	}, {
>  		.virtual	= (unsigned long)VA_VIC2,
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
