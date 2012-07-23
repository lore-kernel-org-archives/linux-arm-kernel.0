From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Jul 2012 16:06:33 +0200
Subject: [PATCH 2/2] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <20120723134929.GW4435@opensource.wolfsonmicro.com>
References: <1343042216-4113-1-git-send-email-andrew@lunn.ch>
 <1343042216-4113-2-git-send-email-andrew@lunn.ch>
 <20120723134929.GW4435@opensource.wolfsonmicro.com>
Message-ID: <20120723140633.GL18778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 02:49:29PM +0100, Mark Brown wrote:
> On Mon, Jul 23, 2012 at 01:16:55PM +0200, Andrew Lunn wrote:
> > Replace the deprecated master->transfer with transfer_one_message()
> > and allow the SPI subsystem handle all the queuing of messages.
> 
> I'll apply this one but not for this merge window, it seems too big a
> change for something that's not been in -next and it's not a fix.

O.K.

Thanks for committing the two other patch so late.

       Andrew
