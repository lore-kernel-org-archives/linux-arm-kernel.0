From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jul 2012 14:49:29 +0100
Subject: [PATCH 2/2] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <1343042216-4113-2-git-send-email-andrew@lunn.ch>
References: <1343042216-4113-1-git-send-email-andrew@lunn.ch>
 <1343042216-4113-2-git-send-email-andrew@lunn.ch>
Message-ID: <20120723134929.GW4435@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 01:16:55PM +0200, Andrew Lunn wrote:
> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.

I'll apply this one but not for this merge window, it seems too big a
change for something that's not been in -next and it's not a fix.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/d899b5a1/attachment.sig>
