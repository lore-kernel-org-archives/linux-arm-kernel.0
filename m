From: khilman@ti.com (Kevin Hilman)
Date: Wed, 05 Jan 2011 09:43:04 -0800
Subject: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build
	break because of clktrctrl_mask
In-Reply-To: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Wed, 5 Jan 2011 16:27:00 +0530")
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87fwt7z1p3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> struct clockdomain member clktrctrl_mask is available for only for OMAP2
> and OMAP3 architectures. Technially it is also used only for these archs
> but this breaks the build with custom OMAP4 configuration.

I'll queue patches 3-5 for the 2.6.38-rc fixes cycle.

With Paul's ack, I can queue the others too, or Paul can decide to take
them via his tree.  Paul can decide.

Kevin
