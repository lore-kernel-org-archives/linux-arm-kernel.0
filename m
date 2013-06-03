From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 04:08:37 +0200
Subject: [PATCH 09/10] arm: add debug uarts for rockchip rk29xx and rk3xxx
 series
In-Reply-To: <201306030101.04370.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
 <201306030101.04370.heiko@sntech.de>
Message-ID: <19033743.NUXvdvXthR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 01:01:03 Heiko St?bner wrote:
> +#if defined(CONFIG_DEBUG_RK29_UART0)
> +#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20060000
> +#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfe060000

0xfed60000 maybe? looks like a typo.

	Arnd
