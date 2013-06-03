From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 3 Jun 2013 09:54:10 +0200
Subject: [PATCH 09/10] arm: add debug uarts for rockchip rk29xx and rk3xxx
 series
In-Reply-To: <19033743.NUXvdvXthR@wuerfel>
References: <201306030055.15413.heiko@sntech.de>
 <201306030101.04370.heiko@sntech.de> <19033743.NUXvdvXthR@wuerfel>
Message-ID: <201306030954.10891.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 3. Juni 2013, 04:08:37 schrieb Arnd Bergmann:
> On Monday 03 June 2013 01:01:03 Heiko St?bner wrote:
> > +#if defined(CONFIG_DEBUG_RK29_UART0)
> > +#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20060000
> > +#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfe060000
> 
> 0xfed60000 maybe? looks like a typo.

ha, correct ... thanks
