From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 10:45:51 +0000
Subject: [PATCH] ARM: mxs: irq_data conversion
In-Reply-To: <20110121102836.GB23596@mail.wantstofly.org>
References: <1295600518-11300-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110121094338.GE13235@n2100.arm.linux.org.uk>
	<20110121101536.GH14956@pengutronix.de>
	<20110121102836.GB23596@mail.wantstofly.org>
Message-ID: <20110121104551.GK13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 11:28:36AM +0100, Lennert Buytenhek wrote:
> I agree with rmk and think that we should just set
> GENERIC_HARDIRQS_NO_DEPRECATED globally (i.e. ARM-wide) at some point,
> and fix up the few remaining old-style users at that point.
> 
> The bulk of the work has been done now, and any further irq_data
> conversions that need to be done can be done in a minute or so each,
> probably on par with the time it would take to patch Kconfig to
> indicate which platforms have been converted and which haven't, so
> we might as well just spend that time on doing the conversion.

If you can do lh7a40x and msm, then with Uwe's (fixed) patch and
vt8500, I think we're there for adding this symbol.
