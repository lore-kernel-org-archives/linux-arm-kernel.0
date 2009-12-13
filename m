From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Dec 2009 13:19:37 +0000
Subject: [PATCH 0/2] pcmcia: two fixes for the pxa pcmcia code
In-Reply-To: <f17812d70912130509i37414557o71a33a66ed047f8e@mail.gmail.com>
References: <f17812d70912130509i37414557o71a33a66ed047f8e@mail.gmail.com>
Message-ID: <20091213131937.GA12645@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 13, 2009 at 09:09:02PM +0800, Eric Miao wrote:
> The two patches below fix the build issue for the pxa part of pcmcia:
> 
> Eric Miao (2):
>       pcmcia: export pxa2xx_drv_pcmcia_{add_one, ops} to other modules
>       pcmcia: fix now incorrect reference of skt->irq by using
> skt->socket.pci_irq

This is already fixed in my tree.
