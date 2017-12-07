From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Dec 2017 11:50:29 +0100
Subject: [PATCH v3 08/15] drm/sun4i: Add LVDS support
In-Reply-To: <CAOFm3uEpnBFUDBHK+SqQ-pGUPcWbGXNrWum4HRJ34tMtoX-2Qw@mail.gmail.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <b900e5963180c94ca02bde178b6674622a127787.1512486553.git-series.maxime.ripard@free-electrons.com>
 <CAOFm3uEpnBFUDBHK+SqQ-pGUPcWbGXNrWum4HRJ34tMtoX-2Qw@mail.gmail.com>
Message-ID: <20171207105029.w4k2zwlr4aygzdzg@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 07, 2017 at 11:14:27AM +0100, Philippe Ombredanne wrote:
> On Tue, Dec 5, 2017 at 4:10 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The TCON supports the LVDS interface to output to a panel or a bridge.
> > Let's add support for it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> []
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> > @@ -0,0 +1,183 @@
> > +/*
> > + * Copyright (C) 2015 NextThing Co
> > + * Copyright (C) 2015-2017 Free Electrons
> > + *
> > + * Maxime Ripard <maxime.ripard@free-electrons.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> 
> Would you consider using the new SPDX ids instead of this fine legalese?
> e.g. this as the top line:
> 
> // SPDX-License-Identifier: GPL-2.0+

I did, and then forgot about it.

This will be in my next iteration, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/af641469/attachment.sig>
