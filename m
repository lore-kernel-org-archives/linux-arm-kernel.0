From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Thu, 8 Sep 2016 13:18:28 -0400
Subject: [PATCH 2/2] ARM: lpc32xx: remove unused header file clock.h
In-Reply-To: <1473303609-20076-2-git-send-email-vz@mleia.com>
References: <1473303609-20076-1-git-send-email-vz@mleia.com>
 <1473303609-20076-2-git-send-email-vz@mleia.com>
Message-ID: <00ff01d209f5$047798f0$0d66cad0$@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-08 at 06:00 +0300, Vladimir Zapolskiy wrote:
> The removed clock.h file is a leftover after moving the platform to a
common
> clock framework driver, it contains unused "struct clk"
> definition, which under circumstances may coalesce with a generic "struct
clk"
> declaration for clock consumers. Also remove useless include of the
removed
> local file from a single source file mach-lpc32xx/pm.c.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/mach-lpc32xx/clock.h | 38 --------------------------------------
>  arch/arm/mach-lpc32xx/pm.c    |  1 -
>  2 files changed, 39 deletions(-)
>  delete mode 100644 arch/arm/mach-lpc32xx/clock.h
...

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
