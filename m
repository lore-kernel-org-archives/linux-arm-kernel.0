From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Mar 2014 11:48:39 +0000
Subject: [PATCH 7/8] tty/serial: add arm64 semihosting earlycon
In-Reply-To: <20140324113821.GF3850@arm.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-8-git-send-email-robherring2@gmail.com>
 <20140324113821.GF3850@arm.com>
Message-ID: <20140324114839.GH3850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 11:38:21AM +0000, Catalin Marinas wrote:
> On Fri, Mar 21, 2014 at 09:08:47PM +0000, Rob Herring wrote:
> > --- /dev/null
> > +++ b/drivers/tty/serial/earlycon-arm-semihost.c
> > @@ -0,0 +1,44 @@
> > +/*
> > + * Copyright (C) 2012 ARM Ltd.
> > + * Author: Catalin Marinas <catalin.marinas@arm.com>
> 
> Nitpick: author should be Mark Zyngier <marc.zyngier@arm.com> 

And a typo in my email: s/Mark/Marc/.

Thanks.

-- 
Catalin
