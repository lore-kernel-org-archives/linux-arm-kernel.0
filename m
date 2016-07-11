From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon, 11 Jul 2016 17:47:19 +0200
Subject: [PATCH] ARM: s3c64xx: smartq: Avoid sparse warnings
In-Reply-To: <20160711084836.12835-1-thierry.reding@gmail.com>
References: <20160711084836.12835-1-thierry.reding@gmail.com>
Message-ID: <20160711154719.GA7702@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 10:48:36AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The smartq_map_io() and smartq_machine_init() functions are used by both
> SmartQ 5 and SmartQ 7 machines and exported via the mach-smartq.h header
> file. However that header file is not included by the mach-smartq.c file
> that implements them, causing sparse warnings.
> 
> Include mach-smartq.h from mach-smartq.c to fix these warnings.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm/mach-s3c64xx/mach-smartq.c | 1 +
>  1 file changed, 1 insertion(+)
>

Thanks, applied.

Best regards,
Krzysztof
