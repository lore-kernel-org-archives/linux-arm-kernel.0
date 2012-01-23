From: sbabic@denx.de (Stefano Babic)
Date: Mon, 23 Jan 2012 16:50:23 +0100
Subject: [PATCH] ARM: mx28: Remove duplicate OCOTP error message
In-Reply-To: <1327332593-27534-1-git-send-email-fabio.estevam@freescale.com>
References: <1327332593-27534-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <4F1D81BF.6010303@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/2012 16:29, Fabio Estevam wrote:
> The mxs_get_ocotp() function already prints an error message in the case of 
> a timeout, so no need to print them again in the board files.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mxs/mach-m28evk.c  |    5 +----
>  arch/arm/mach-mxs/mach-mx28evk.c |    6 +-----
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
> index 2f27582..eec1257 100644
> --- a/arch/arm/mach-mxs/mach-m28evk.c
> +++ b/arch/arm/mach-mxs/mach-m28evk.c

Acked-by: Stefano Babic <sbabic@denx.de>

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
=====================================================================
