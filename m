From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Oct 2015 11:05:19 +0200
Subject: [PATCH v3 4/5] clk: sunxi: codec clock support
In-Reply-To: <20151002204427.GZ12338@codeaurora.org>
References: <1443512353-28073-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443512353-28073-5-git-send-email-maxime.ripard@free-electrons.com>
 <20151002204427.GZ12338@codeaurora.org>
Message-ID: <20151005090519.GF2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 01:44:27PM -0700, Stephen Boyd wrote:
> On 09/29, Maxime Ripard wrote:
> > diff --git a/drivers/clk/sunxi/clk-a10-codec.c b/drivers/clk/sunxi/clk-a10-codec.c
> > new file mode 100644
> > index 000000000000..aaeccf8cde39
> > --- /dev/null
> > +++ b/drivers/clk/sunxi/clk-a10-codec.c
> > @@ -0,0 +1,45 @@
> > +/*
> > + * Copyright 2013 Emilio L?pez
> > + *
> > + * Emilio L?pez <emilio@elopez.com.ar>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> 
> Is this include used?

It isn't, I've removed it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/6a238a62/attachment.sig>
