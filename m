From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Apr 2018 15:07:14 +0100
Subject: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
In-Reply-To: <20180419133233.GE7369@piout.net>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
 <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
 <20180413181251.GG22187@piout.net>
 <20180417110358.GD8973@sirena.org.uk>
 <20180419133233.GE7369@piout.net>
Message-ID: <20180419140714.GF27188@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 03:32:33PM +0200, Alexandre Belloni wrote:

> My suggestion was to add an MFD driver that would match the current
> compatible and either have an atmel,usart-mode property or maybe more
> risky, check whether there are children nodes. Based on that, the
> correct platform device can be added, either an usart or an spi master
> device can be registered.

Yeah, that's another approach which could work and is a bit easier from
the DT point of view - the PXA stuff predated DT and was adapted into
it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180419/ad3f251e/attachment.sig>
