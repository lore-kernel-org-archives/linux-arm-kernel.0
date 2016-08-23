From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Aug 2016 14:50:18 +0200
Subject: [PATCH] ARM: pxa: remove irq init from dt machines
In-Reply-To: <1471213495-2315-1-git-send-email-robert.jarzmik@free.fr>
References: <1471213495-2315-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <2040480.LI9qyCOOTW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 15, 2016 12:24:55 AM CEST Robert Jarzmik wrote:
> The init_irq and handle_irq can be declared through standard irqchip
> declaration and are not necessary in machine descriptions.
> 
> This is another step towards the generic kernel for the pxa
> architecture.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Arnd Bergmann <arnd@arndb.de>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
