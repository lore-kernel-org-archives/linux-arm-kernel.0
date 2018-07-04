From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Jul 2018 12:43:55 +0100
Subject: [RFC net-next 15/15] net: lora: Add Semtech SX1301
In-Reply-To: <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
 <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
Message-ID: <20180704114355.GB11693@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 06:40:41PM +0200, Andreas F?rber wrote:

> Do you have an alternative solution for abstraction? A regmap would seem
> to require putting everything into a monolithic SX1301 driver despite
> those connected chipsets actually being regular, external SPI chips that
> could also be attached to non-SX1301 SPI masters.

I'm suggesting a regmap for those external SPI chips.  It doesn't matter
what the host uses.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180704/f1ba9f60/attachment-0001.sig>
