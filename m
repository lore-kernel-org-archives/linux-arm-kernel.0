From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 May 2015 11:38:06 +0100
Subject: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada
 SoCs
In-Reply-To: <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150526103806.GN21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 11:44:43AM +0200, Gregory CLEMENT wrote:
> The commit df59fa7f4bca "spi: orion: support armada extended baud
> rates" made the assumptions that all the Armada SoCs supported the
> same maximum frequency. However, according the hardware datasheet, the
> maximum frequency supported by the Armada 370 SoC is tclk/4, for the
> Armada XP, Armada 38x and Armada 39x SoCs the limitation is 50MHz and
> for the Armada 375 it is tclk/15.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/c6a80015/attachment.sig>
