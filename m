From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2011 14:33:13 +0000
Subject: [GIT PULL v2] at91: drivers for 3.3
In-Reply-To: <4EEB388A.1040906@atmel.com>
References: <4EEA0DF6.3050408@atmel.com> <4EEB388A.1040906@atmel.com>
Message-ID: <201112161433.13159.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 December 2011, Nicolas Ferre wrote:
> This is the version 2 of the pull request related to Ethernet drivers for AT91.
> As you requested, it is based on arm-soc/drivers/macb-gem branch:
> 
> The following changes since commit 0116da4fcc1ae8a80d9002441e98768f2a6fa2fe:
> 
>   macb: allow GEM to have configurable receive buffer size (2011-11-22 15:21:20 +0000)
> 
> are available in the git repository at:
>   git://github.com/at91linux/linux-at91.git for-arnd-3.3-driversV2
> 
> Jean-Christophe PLAGNIOL-VILLARD (1):
>       net/macb: add DT support for Cadence macb/gem driver
> 
> Nicolas Ferre (2):
>       ARM: at91/net: add macb ethernet controller in 9g45/9g20 DT
>       net/at91_ether: use gpio_is_valid for phy IRQ line

Pulled into next/drivers, thanks for the quick update!

	Arnd
