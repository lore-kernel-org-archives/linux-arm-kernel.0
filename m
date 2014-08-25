From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Aug 2014 10:00:01 +0200
Subject: [RFC 5/7] bcma: get IRQ numbers from dt
In-Reply-To: <1408915485-8078-7-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
 <1408915485-8078-7-git-send-email-hauke@hauke-m.de>
Message-ID: <1408960991.IQOFBLWbOW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 August 2014 23:24:43 Hauke Mehrtens wrote:
> It is not possible to auto detect the irq numbers used by the cores on
> an arm SoC. If bcma was registered with device tree it will search for
> some device tree nodes with the irq number and add it to the core
> configuration.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
