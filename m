From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 25 Apr 2016 12:08:57 -0400
Subject: [PATCH v2 4/4] ARM: lpc32xx: remove legacy irq controller driver
In-Reply-To: <1461546044-25758-1-git-send-email-vz@mleia.com>
References: <1461545990-25560-1-git-send-email-vz@mleia.com>
 <1461546044-25758-1-git-send-email-vz@mleia.com>
Message-ID: <1461600537.6934.6.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-04-25 at 04:00 +0300, Vladimir Zapolskiy wrote:
> New NXP LPC32xx irq chip driver is used instead of a legacy one.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> Changes from v1 to v2:
> * none, this is a new change
> 
>  arch/arm/mach-lpc32xx/Makefile |   2 +-
>  arch/arm/mach-lpc32xx/irq.c    | 477 -----------------------------------------
>  2 files changed, 1 insertion(+), 478 deletions(-)
>  delete mode 100644 arch/arm/mach-lpc32xx/irq.c
> 
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
