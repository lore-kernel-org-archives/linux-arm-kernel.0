From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 6 Jul 2013 01:51:54 +0200 (CEST)
Subject: [PATCH 6/9] clocksource: dw_apb_timer: quirk for inverted int mask
In-Reply-To: <201307060054.35996.heiko@sntech.de>
References: <201307060051.09716.heiko@sntech.de>
 <201307060054.35996.heiko@sntech.de>
Message-ID: <alpine.DEB.2.02.1307060150030.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 6 Jul 2013, Heiko St?bner wrote:

> Some timer variants use an inverted setting to mask the timer interrupt.
> Therefore add a quirk to handle these variants.

And by that add even more pointless conditionals into critical code
pathes.
