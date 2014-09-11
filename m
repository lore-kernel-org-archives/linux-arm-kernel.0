From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Sep 2014 20:33:25 +0100
Subject: SPI and module auto-loading
In-Reply-To: <54119DB6.8020807@collabora.co.uk>
References: <54119DB6.8020807@collabora.co.uk>
Message-ID: <20140911193325.GT4015@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 03:03:50PM +0200, Javier Martinez Canillas wrote:

> This can be easily worked around (and probably why it never was an issue) if
> the OF and SPI tables are kept in sync but I don't know if that is a hard
> requirement for all use-cases (e.g: a SPI driver that is DT only?).

I'm not sure I see that as an interesting use case, it seems better to
have drivers usable without DT and it's trivial to do so.

> I'm sending an RFC patch [1] to know what you think about it.
> 
> Thanks a lot and best regards,
> Javier
> 
> [0]: https://lkml.org/lkml/2014/9/11/127
> [1]
> From a7cd35209a597a578df6c801e5ff7b63b584bf3e Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Date: Thu, 11 Sep 2014 14:31:04 +0200
> Subject: [PATCH RFC] spi: core: report OF style modalias when probing using DT

We already have a perfectly good way of sending patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/28ce660d/attachment.sig>
