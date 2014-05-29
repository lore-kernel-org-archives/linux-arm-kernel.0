From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 May 2014 09:07:05 +0100
Subject: [PATCH v8 5/8] arm64: Add ftrace support
In-Reply-To: <20140528201955.GJ5099@sirena.org.uk>
References: <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-6-git-send-email-takahiro.akashi@linaro.org>
 <20140528201955.GJ5099@sirena.org.uk>
Message-ID: <20140529080705.GD29812@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 09:19:55PM +0100, Mark Brown wrote:
> On Wed, Apr 30, 2014 at 06:54:33PM +0900, AKASHI Takahiro wrote:
> 
> > +/*
> > + * arch/arm64/kernel/entry-ftrace.S
> > + *
> > + * Copyright (C) 2013 Linaro Limited
> > + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/ftrace.h>
> > +#include <asm/insn.h>
> 
> asm/insn.h contains a bunch of C stuff which won't build without
> __ASSEMBLY__ guards unless I'm missing something (I'm working with a
> non-mainline tree so I might be).

The guards are added earlier in this series.

Will
