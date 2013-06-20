From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 12:17:47 +0200
Subject: [PATCH v2] irqchip: add support for MOXA ART SoCs
In-Reply-To: <1371718732-12680-1-git-send-email-jonas.jensen@gmail.com>
References: <20130618154104.7f8115c7@skate>
 <1371718732-12680-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201306201217.47903.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Jonas Jensen wrote:
> This patch adds an irqchip driver for the main interrupt controller found
> on MOXA ART SoCs.
> 
> v2:
> * use irq_chip_generic
> * remove macro duplicates
> 
> Applies to next-20130619
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
