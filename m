From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2009 19:58:08 +0000
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <20091217194837.GD4440@n2100.arm.linux.org.uk>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
	<84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
	<20091217181718.GA4440@n2100.arm.linux.org.uk>
	<20091217183517.GC10707@synopsys.com>
	<20091217190613.GB4440@n2100.arm.linux.org.uk>
	<20091217191401.GD10707@synopsys.com>
	<20091217193826.GE362@shareable.org>
	<20091217194837.GD4440@n2100.arm.linux.org.uk>
Message-ID: <20091217195808.GE4440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 07:48:37PM +0000, Russell King - ARM Linux wrote:
> Given the lack of progress/bug reporting on ARM uclinux, the lack of
> platform support and the lack of configurations, my view is that there
> is no one actually using it.  I know that I don't particularly take any
> care with respect to uclinux when making changes to the MMU based kernels.
> Why bother if apparantly no one's using it?

Jamie,

As you seem to be a user of uclinux on ARM, could you help ensure that
the support there is bug fixed and we at least have a configuration file
which kautobuild can use to provide feedback on the build status of
uclinux on ARM please?
