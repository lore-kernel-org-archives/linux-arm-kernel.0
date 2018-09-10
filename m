From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 10 Sep 2018 19:06:18 +0200
Subject: [PATCH v3 1/2] ARM: s3c24xx: formatting cleanup in mach-mini2440.c
In-Reply-To: <20180907215446.15160-1-sed@free.fr>
References: <20180907215446.15160-1-sed@free.fr>
Message-ID: <20180910170618.dfe6uxngz72vodr2@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 11:54:45PM +0200, Cedric Roux wrote:
> Running:
>     scripts/checkpatch.pl -f arch/arm/mach-s3c24xx/mach-mini2440.c
> revealed several errors and warnings.
> 
> They were all removed, except one which is an #if 0 around the declaration
> of a gpio pin. This needs some more investigation and I prefer to let it
> here. This is not some dead code.
> 
> 'printk' was replaced by 'pr_info'.
> 
> Signed-off-by: Cedric Roux <sed@free.fr>
> ---
>  arch/arm/mach-s3c24xx/mach-mini2440.c | 80 ++++++++++++++-------------

Thanks, applied.

Best regards,
Krzysztof
