From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Jun 2016 15:23:20 +0200
Subject: [PATCH] ARM: orion5x: make orion5x_legacy_handle_irq static
In-Reply-To: <1465466345-29560-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465466345-29560-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160609132320.GG30205@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 10:59:05AM +0100, Ben Dooks wrote:
> The orion5x_legacy_handle_irq() is not used or declared outside
> of irq.c so make it static to avoid the following warning:
> 
> arch/arm/mach-orion5x/irq.c:30:23: warning: symbol 'orion5x_legacy_handle_irq' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
