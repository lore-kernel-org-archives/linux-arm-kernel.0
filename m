From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Jun 2010 16:54:51 +0200
Subject: [PATCH 1/2] ISL6271A voltage regulator support.
In-Reply-To: <20100607114856.GD5993@sirena.org.uk>
References: <1275887908-22285-1-git-send-email-marek.vasut@gmail.com>
	<20100607114856.GD5993@sirena.org.uk>
Message-ID: <201006071654.51324.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 7. ?ervna 2010 13:48:56 Mark Brown napsal(a):
> On Mon, Jun 07, 2010 at 07:18:27AM +0200, Marek Vasut wrote:
> > This device is very simple, it supports only one LDO. This single LDO is
> > programmed over I2C to 16 possible voltages.
> 
> Marek, you really should know to CC patches to maintainers by now.  This
> is not CCed to myself, Liam or lkml.

I rather should have marked this RFC ... this code probably doesn't even work, I 
just want someone who has zaurus to test it (they are CCed). Sorry for the 
confusion.
> 
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/machine.h>
> 
> Why are you including machine.h here?  I can't actually see any suspect
> code in the driver so I suspect it's unused.
> 
> Otherwise this looks good.
