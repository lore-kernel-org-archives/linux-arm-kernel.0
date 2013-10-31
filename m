From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Oct 2013 00:48:15 +0000
Subject: [PATCH] watchdog: imx2_wdt: add module device table
In-Reply-To: <20131031004338.GA20335@roeck-us.net>
References: <E1VbfdE-0003gA-4q@rmk-PC.arm.linux.org.uk>
 <20131031004338.GA20335@roeck-us.net>
Message-ID: <20131031004815.GT16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 05:43:38PM -0700, Guenter Roeck wrote:
> On Wed, Oct 30, 2013 at 11:57:00PM +0000, Russell King wrote:
> > Add the module device table declaration so the module can be loaded
> > automatically at boot time.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Hi Russell,
> 
> Wim should have this patch in his queue already, as 'watchdog: imx2_wdt:
> expose module alias for loading from device-tree', submitted by Niels
> de Vos back in July.

Any reason it hasn't made it in yet?  We had a merge window back in
September where, if we're not happy to apply it as a fix during -rc,
it could have gone in.  I see watchdog stuff did merge during the
last merge window...
