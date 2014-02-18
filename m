From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 18 Feb 2014 18:44:44 +0400
Subject: [PATCH v2 RESEND 1/3] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <1391328466-30873-1-git-send-email-shc_work@mail.ru>
References: <1391328466-30873-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140218184444.a942a399e1dec0a286d5251b@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  2 Feb 2014 12:07:46 +0400
Alexander Shiyan <shc_work@mail.ru> wrote:

> This adds the irqchip driver for Cirrus Logic CLPS711X series SoCs.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/Kconfig                |   2 -
>  arch/arm/mach-clps711x/common.h |   3 +
>  drivers/irqchip/Kconfig         |   8 ++
>  drivers/irqchip/Makefile        |   1 +
>  drivers/irqchip/irq-clps711x.c  | 243 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 255 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/irqchip/irq-clps711x.c
...

Ping.

-- 
Alexander Shiyan <shc_work@mail.ru>
