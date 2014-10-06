From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 6 Oct 2014 13:38:20 +0200
Subject: [PATCH v7 01/11] mfd: add atmel-hlcdc driver
In-Reply-To: <20141006104917.GF25202@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141006104917.GF25202@ulmo>
Message-ID: <20141006133820.4905847a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Oct 2014 12:49:17 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Oct 01, 2014 at 04:52:58PM +0200, Boris Brezillon wrote:
> [...]
> > diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
> [...]
> > @@ -0,0 +1,122 @@
> > +/*
> > + * Copyright (C) 2014 Free Electrons
> > + * Copyright (C) 2014 Atmel
> > + *
> > + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published by
> > + * the Free Software Foundation.
> [...]
> > +MODULE_LICENSE("GPL");
> 
> Should be "GPL v2" according to the header comment.

I'll fix that.

> 
> Thierry



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
