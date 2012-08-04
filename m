From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 4 Aug 2012 12:11:00 +0100
Subject: [PATCH 2/2] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <1343042216-4113-2-git-send-email-andrew@lunn.ch>
References: <1343042216-4113-1-git-send-email-andrew@lunn.ch>
 <1343042216-4113-2-git-send-email-andrew@lunn.ch>
Message-ID: <20120804111100.GF10523@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 01:16:55PM +0200, Andrew Lunn wrote:
> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.

Applied, thanks.
