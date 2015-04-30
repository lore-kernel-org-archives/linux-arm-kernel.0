From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 Apr 2015 10:03:03 +0200
Subject: [PATCH v3 0/7] ARM: at91/dt: kizbox: update and rename to
 at91-kizbox
In-Reply-To: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
References: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
Message-ID: <5541E1B7.7080602@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/04/2015 09:33, Ga?l PORTAY a ?crit :
> Hi,
> 
> This patchset renames the kizbox board into at91-kizbox to match AT91 naming
> convention, sanitize and sorts nodes by address when possible (or
> alphabetically if not applicable).
> 
> It also updates the following features:
> - uses proper serial uart (only USART3 is accessible),
> - fixes gpio-keys active level and rename,
> - moves leds to pwm support (using tcb-pwm driver) and rename as well,
> - re-sizes nand mtd partitions and
> - updates chosen-node (bootargs + set linux stdout path to DBGU),
> 
> Regards,
> Ga?l PORTAY
> 
> Changes since v1:
> - Split into patches for review
> 
> Changes since v2:
> - Rebase onto v4.0.1
> - Change board-name in comments at rename (patch 1)
> 
> Ga?l PORTAY (7):
>   ARM: at91/dt: kizbox: rename to at91-kizbox
>   ARM: at91/dt: at91-kizbox: sanitize file
>   ARM: at91/dt: at91-kizbox: user proper serial uart
>   ARM: at91/dt: at91-kizbox: gpio-keys related changes
>   ARM: at91/dt: at91-kizbox: leds related changes
>   ARM: at91/dt: at91-kizbox: re-size nand partitions
>   ARM: at91/dt: at91-kizbox: update chosen node

On the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Stacked on at91-4.2-dt (should also appear shortly in linux-next).

Thanks Ga?l, bye.

>  arch/arm/boot/dts/Makefile        |   2 +-
>  arch/arm/boot/dts/at91-kizbox.dts | 159 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/kizbox.dts      | 150 -----------------------------------
>  3 files changed, 160 insertions(+), 151 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91-kizbox.dts
>  delete mode 100644 arch/arm/boot/dts/kizbox.dts
> 


-- 
Nicolas Ferre
