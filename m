From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 2 Dec 2012 13:24:00 +0000
Subject: [PATCH 1/2] ARM: ixp4xx: Moving the timer flags control in
 ixp4xx_irq_ack() procedure
In-Reply-To: <1354435770-2719-1-git-send-email-shc_work@mail.ru>
References: <201212020011.42105.arnd@arndb.de>
 <1354435770-2719-1-git-send-email-shc_work@mail.ru>
Message-ID: <201212021324.00537.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 December 2012, Alexander Shiyan wrote:
> 
> Rather than modify the EOI flags directly in the timer interrupt,
> let's deal with these flags in the ixp4xx_irq_ack() procedure.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Acked-by: Arnd Bergmann <arnd@arndb.de>
