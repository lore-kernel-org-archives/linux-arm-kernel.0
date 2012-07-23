From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jul 2012 14:15:15 +0100
Subject: [PATCH 1/2] spi-orion: remove uneeded spi_info
In-Reply-To: <1343042216-4113-1-git-send-email-andrew@lunn.ch>
References: <1343042216-4113-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120723131515.GT4435@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 01:16:54PM +0200, Andrew Lunn wrote:
> From: Michael Walle <michael@walle.cc>
> 
> This was formerly used to store the tclk value. This is now discovered
> using the clk API, rather than pass it as platform data.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/2bf89a74/attachment.sig>
