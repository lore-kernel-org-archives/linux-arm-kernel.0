From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 19 Sep 2018 19:11:05 +0200
Subject: [PATCH] ARM: s3c24xx: fix usage of pr_info/pr_cont
In-Reply-To: <20180917204350.15192-1-sed@free.fr>
References: <20180917204350.15192-1-sed@free.fr>
Message-ID: <20180919171105.GA10129@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 10:43:50PM +0200, Cedric Roux wrote:
> This commit fixes the wrong usage of pr_info introduced by the
> commit e728e4f20100 ("ARM: s3c24xx: formatting cleanup in
> mach-mini2440.c").
> 
> Since the idea is to print on a single line, pr_cont has to be used.
> 
> Signed-off-by: Cedric Roux <sed@free.fr>
> ---
>  arch/arm/mach-s3c24xx/mach-mini2440.c | 6 +++---

Thanks, applied.

Best regards,
Krzysztof
