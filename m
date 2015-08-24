From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Aug 2015 12:16:20 +0200
Subject: [PATCH linux-next v4 1/5] mtd: spi-nor: notify (Q)SPI controller
 about protocol change
In-Reply-To: <9649a13a50c33ef38045342353fc487a914ae337.1440410236.git.cyrille.pitchen@atmel.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <9649a13a50c33ef38045342353fc487a914ae337.1440410236.git.cyrille.pitchen@atmel.com>
Message-ID: <201508241216.20506.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 24, 2015 at 12:13:56 PM, Cyrille Pitchen wrote:
> Once the Quad SPI mode has been enabled on a Micron flash memory, this
> device expects ALL the following commands to use the SPI 4-4-4 protocol.
> The (Q)SPI controller needs to be notified about the protocol change so it
> can adapt and keep on dialoging with the Micron memory.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Awesome,

Acked-by: Marek Vasut <marex@denx.de>

If this could be applied separately (since I want to use the same functionality
for the Cadence QSPI driver), I'd be really happy too :)

Best regards,
Marek Vasut
