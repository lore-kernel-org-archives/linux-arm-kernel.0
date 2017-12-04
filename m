From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Dec 2017 18:20:27 +0000
Subject: [PATCH 4/8] ASoC: uniphier: add support for UniPhier EVEA codec
In-Reply-To: <20171122114321.29196-5-suzuki.katsuhiro@socionext.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-5-suzuki.katsuhiro@socionext.com>
Message-ID: <20171204182027.2k5uw5og65h6ac7w@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 08:43:17PM +0900, Katsuhiro Suzuki wrote:

> +++ b/sound/soc/uniphier/evea.c
> @@ -0,0 +1,567 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Socionext UniPhier EVEA ADC/DAC codec driver.
> + *
> + * Copyright (c) 2016-2017 Socionext Inc.

Make the entire comment a C++ comment, don't mix and match like this -
it's ugly.  Otherwise this looks good so I'll apply it, please send a
followup patch fixing this (and I guess the same thing will apply to
other files).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171204/0b9857ee/attachment.sig>
