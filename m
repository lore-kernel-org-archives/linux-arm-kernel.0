From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:23:12 +0100
Subject: some i.MX23/28 patches
In-Reply-To: <4D416FE1.3010409@ru.mvista.com>
References: <1296128413-20778-1-git-send-email-s.hauer@pengutronix.de>
	<4D416FE1.3010409@ru.mvista.com>
Message-ID: <20110127132311.GY9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 04:15:13PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 27-01-2011 14:40, Sascha Hauer wrote:
> 
> >The following contains some i.MX23/28 cleanup patches.
> 
> >Sascha
> 
> >The following changes since commit 376e9c5848abef8c72c09bd89f2f7ee128caa104:
> 
> >   ARM: mxs: add initial pm support (2011-01-26 08:30:49 +0100)
> 
> >are available in the git repository at:
> >   none ..BRANCH.NOT.VERIFIED..
> 
>    Forgot to push?

No, I didn't really wanted to push. git-request-pull is just handy to
create an overall diffstat.

Sascha

> 
> >Sascha Hauer (4):
> >       ARM i.MX23/28: deobfuscate gpio initialization
> >       ARM i.MX23/28: do not use complicated macros if not necessary
> >       ARM i.MX23: remove reserved register defines
> >       ARM i.MX28: remove reserved register defines
> >
> >  arch/arm/mach-mxs/gpio.c              |   45 +++++----
> >  arch/arm/mach-mxs/regs-clkctrl-mx23.h |  124 -----------------------
> >  arch/arm/mach-mxs/regs-clkctrl-mx28.h |  177 ---------------------------------
> >  3 files changed, 24 insertions(+), 322 deletions(-)
> 
> WBR, Sergei
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
