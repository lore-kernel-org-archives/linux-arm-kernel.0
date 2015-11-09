From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 10:12:37 +0100
Subject: [PATCH v2] ARM: debug: add support for Palmchip BK-310x UART
In-Reply-To: <1447024300-7279-1-git-send-email-mans@mansr.com>
References: <1447024300-7279-1-git-send-email-mans@mansr.com>
Message-ID: <5029218.joxW0cEizl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 November 2015 23:11:40 Mans Rullgard wrote:
> Some SoCs use a Palmchip BK-310x UART which is mostly 16550 compatible
> but with a different register layout. While this UART has previously
> only been supported in MIPS based chips (Alchemy, Ralink), the ARM based
> SMP87xx series from Sigma Designs also uses it.
> 
> This patch allows the debug console to work with this type of UART.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
