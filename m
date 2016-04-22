From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 22 Apr 2016 09:53:50 +0200 (CEST)
Subject: [PATCH 1/2] clocksource: sp804: Add support for OX810SE 24bit
 timer width
In-Reply-To: <20160422074645.GA3974@linaro.org>
References: <1459520559-13110-1-git-send-email-narmstrong@baylibre.com>
 <1459520559-13110-2-git-send-email-narmstrong@baylibre.com>
 <20160422074645.GA3974@linaro.org>
Message-ID: <alpine.DEB.2.11.1604220953000.3941@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr 2016, Daniel Lezcano wrote:

> On Fri, Apr 01, 2016 at 04:22:38PM +0200, Neil Armstrong wrote:
> > In order to support the Dual-Timer on the Oxford Semiconductor OX810SE SoC,
> > implement variable counter width, keeping 32bit as default width.
> > Add new compatible string oxsemi,ox810se-rps-timer in order to select
> > the 24bit counter width.
> > 
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  drivers/clocksource/timer-sp804.c | 107 ++++++++++++++++++++++++--------------
> >  include/clocksource/timer-sp804.h |  42 ++++++++++++---
> >  2 files changed, 102 insertions(+), 47 deletions(-)
> 
> I will take those patches but this driver really deserves a cleanup.

If it deserves a cleanup, then this should happen _BEFORE_ we add new
functionality to it.

Thanks,

	tglx
