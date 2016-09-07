From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 7 Sep 2016 03:30:54 +0200
Subject: [PATCH 1/4] ARM: mv78xx0: simplify ethernet device creation
In-Reply-To: <20160906140623.2853066-1-arnd@arndb.de>
References: <20160906140623.2853066-1-arnd@arndb.de>
Message-ID: <20160907013054.GA10007@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 04:06:20PM +0200, Arnd Bergmann wrote:
> Out of the four ethernet devices on mv78xx0, only the first one
> has an error interrupt line, for the other ones we pass NO_IRQ
> and then ignore the argument.
> 
> In order to get closer to complete remove of NO_IRQ, this simply
> drops the unused function arguments.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
