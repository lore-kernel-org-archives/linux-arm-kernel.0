From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 17 Feb 2014 10:02:48 +0100
Subject: [PATCH] arm: imx: remove MACH_MXLADS
In-Reply-To: <1392612187.657010375@f87.i.mail.ru>
References: <1392573811.28866.22.camel@x220>
 <1392578464.996901773@f49.i.mail.ru> <1392582900.28866.85.camel@x220>
 <1392612187.657010375@f87.i.mail.ru>
Message-ID: <1392627768.10966.23.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-02-17 at 08:43 +0400, Alexander Shiyan wrote:
> It seems that even in the current state, Kconfig for i.MX contains an error.
> As a start, we should rename ARCH_MX1ADS to MACH_MX1ADS first.

Last year I admitted that I didn't entirely grasped the differences
between "arch", "platform", and "machine" in the arch/arm universe[1].
Perhaps someone could help me understand why it's better to use
MACH_MX1ADS here.

Paul Bolle


[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2013-May/038204.html
