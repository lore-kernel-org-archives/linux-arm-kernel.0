From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Feb 2012 10:54:08 -0800
Subject: [PATCH 14/16] ARM: omap: fix wrapped error messages in
 omap_hwmod.c
In-Reply-To: <alpine.DEB.2.00.1202081039590.26892@utopia.booyaka.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAZK-0006Hi-Vm@rmk-PC.arm.linux.org.uk>
 <alpine.DEB.2.00.1202081039590.26892@utopia.booyaka.com>
Message-ID: <20120208185407.GN29796@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120208 09:09]:
> On Wed, 8 Feb 2012, Russell King - ARM Linux wrote:
> 
> > While trying to debug my OMAP platforms, they emitted this message:
> > 
> > omap_hwmod: %s: enabled state can only be entered from initialized, idle, or disabled state
> > 
> > The following backtrace said it was from a function called '_enable',
> > which didn't provide much clue.  Grepping didn't find it either.
> > 
> > The message is wrapped, so unwrap the message so grep can find it.  Do
> > the same for three other messages in this file.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Thanks, I'll queue this for 3.4.

Looks like Russell is willing to take potential flamage and argue
this should go into -rc because of the hard to find message.

Care to ack instead, or do you have objections to this being
merged during the -rc?

Regards,

Tony
