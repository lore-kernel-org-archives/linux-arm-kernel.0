From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Thu, 8 Sep 2016 13:17:34 -0400
Subject: [PATCH 1/2] ARM: lpc32xx: remove unused header file mach/irqs.h
In-Reply-To: <1473303609-20076-1-git-send-email-vz@mleia.com>
References: <1473303609-20076-1-git-send-email-vz@mleia.com>
Message-ID: <00fd01d209f4$e487c920$ad975b60$@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-08 at 06:00 +0300, Vladimir Zapolskiy wrote:
> The removed LPC32xx mach/irqs.h file is not included in any source code,
> function declaration lpc32xx_init_irq() is also unused, remove them as
leftovers
> after switching to a new interrupt controller driver.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/mach-lpc32xx/common.h            |   1 -
>  arch/arm/mach-lpc32xx/include/mach/irqs.h | 117
------------------------------
>  2 files changed, 118 deletions(-)
>  delete mode 100644 arch/arm/mach-lpc32xx/include/mach/irqs.h
> 
...

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
