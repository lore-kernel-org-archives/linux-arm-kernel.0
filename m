From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 24 Nov 2009 18:36:57 +0100
Subject: [PATCH] ARM: MX3: fix CPU revision number detection
In-Reply-To: <20091121192249.GF13956@n2100.arm.linux.org.uk>
References: <1258820364-32693-1-git-send-email-daniel@caiaq.de>
	<20091121190037.GE13956@n2100.arm.linux.org.uk>
	<20091121192249.GF13956@n2100.arm.linux.org.uk>
Message-ID: <20091124173657.GC14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 07:22:49PM +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 21, 2009 at 07:00:37PM +0000, Russell King - ARM Linux wrote:
> > On Sat, Nov 21, 2009 at 05:19:24PM +0100, Daniel Mack wrote:
> > > +#include <asm/io.h>
> > 
> > I see red.  linux/io.h please.
> 
> BTW, as a reminder, the reason I pick up on these soo much is because
> I've configured my mail client (mutt) to highlight them:
> 
> color body white red "\\+.*(#include <(asm|mach)/(gp)?io\.h>|return -1|default n)"
> 
> which matches new uses of 'asm/io.h', 'mach/io.h', 'asm/gpio.h',
> 'mach/gpio.h', 'return -1' and 'default n' in patches.

That is quite handy, but when my own patches are parsed by mutt, it's
usually too late ;) I'll hack a git-pre-commit script to prevent that in
the future. Or does anyone have that ready yet?

Daniel
