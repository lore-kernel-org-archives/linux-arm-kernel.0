From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 8 Feb 2012 10:40:47 -0700 (MST)
Subject: [PATCH 14/16] ARM: omap: fix wrapped error messages in
 omap_hwmod.c
In-Reply-To: <E1RvAZK-0006Hi-Vm@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAZK-0006Hi-Vm@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1202081039590.26892@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Feb 2012, Russell King - ARM Linux wrote:

> While trying to debug my OMAP platforms, they emitted this message:
> 
> omap_hwmod: %s: enabled state can only be entered from initialized, idle, or disabled state
> 
> The following backtrace said it was from a function called '_enable',
> which didn't provide much clue.  Grepping didn't find it either.
> 
> The message is wrapped, so unwrap the message so grep can find it.  Do
> the same for three other messages in this file.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks, I'll queue this for 3.4.


- Paul
