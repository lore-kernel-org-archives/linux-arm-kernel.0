From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 May 2018 09:30:40 +0100
Subject: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
In-Reply-To: <6a59e071-3159-4939-8535-6c7a9d491379@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <20180517050406.GF20254@sirena.org.uk>
 <6a59e071-3159-4939-8535-6c7a9d491379@microchip.com>
Message-ID: <20180523083040.GC4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 11:10:28AM +0300, Radu Pirea wrote:
> On 05/17/2018 08:04 AM, Mark Brown wrote:

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Driver for AT91 USART Controllers as SPI
> > > + *
> > > + * Copyright (C) 2018 Microchip Technology Inc.

> > Make the entire block a C++ comment so it looks more intentional rather
> > tha mixing C and C++.

> I know it's ugly, but SPDX license identifier must be in a separate comment
> block.

No, it doesn't - it just needs to be the first line of the file.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/77fafae7/attachment.sig>
