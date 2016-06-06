From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 6 Jun 2016 21:59:23 +0300
Subject: [PATCH 04/13] ARM: shmobile: r8a7792: basic SoC support
In-Reply-To: <2352834.cNFKgiQiVO@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2352834.cNFKgiQiVO@wasted.cogentembedded.com>
Message-ID: <8b7f03a3-b15e-e7b3-4bca-63d18c19b80e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/01/2016 01:18 AM, Sergei Shtylyov wrote:

> Add minimal support for the R-Car V2H (R8A7792) SoC.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
[...]

> Index: renesas/arch/arm/mach-shmobile/setup-r8a7792.c
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm/mach-shmobile/setup-r8a7792.c
> @@ -0,0 +1,34 @@
> +/*
> + * r8a7792 processor support
> + *
> + * Copyright (C) 2014  Renesas Electronics Corporation

    Hm, I thought I'd stamped Cogent's copyright here... Please hold on with 
merging this patch.

[...]

MBR, Sergei
