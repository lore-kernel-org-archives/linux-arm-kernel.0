From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 7 Apr 2014 14:56:49 -0700
Subject: [PATCH v6 2/5] ARM: Add Krait L2 register accessor functions
In-Reply-To: <20140407201838.GC20822@pd.tnic>
References: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
 <1396641450-12854-3-git-send-email-sboyd@codeaurora.org>
 <20140407201838.GC20822@pd.tnic>
Message-ID: <20140407215649.GH9985@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07, Borislav Petkov wrote:
> On Fri, Apr 04, 2014 at 12:57:27PM -0700, Stephen Boyd wrote:
> > diff --git a/arch/arm/common/krait-l2-accessors.c b/arch/arm/common/krait-l2-accessors.c
> > new file mode 100644
> > index 000000000000..5d514bbc88a6
> > --- /dev/null
> > +++ b/arch/arm/common/krait-l2-accessors.c
> > @@ -0,0 +1,58 @@
> > +/*
> > + * Copyright (c) 2011-2013, The Linux Foundation. All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 and
> > + * only version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> 
> Can we refer to COPYING here instead of adding that boilerplate to every
> file?

No. This is the template I'm told to use.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
