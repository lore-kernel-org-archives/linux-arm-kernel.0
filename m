From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 7 Sep 2016 03:49:37 +0200
Subject: [PATCH 4/4] ARM: orion5x: remove extraneous NO_IRQ
In-Reply-To: <20160906140623.2853066-4-arnd@arndb.de>
References: <20160906140623.2853066-1-arnd@arndb.de>
 <20160906140623.2853066-4-arnd@arndb.de>
Message-ID: <20160907014937.GB10007@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 04:06:23PM +0200, Arnd Bergmann wrote:
> rd88f6183ap-ge passes NO_IRQ as the interrupt line for its m25p80
> NOR flash. However, this device never uses an interrupt and the
> driver doesn't care, so we can simply remove the deprecated constant
> here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
