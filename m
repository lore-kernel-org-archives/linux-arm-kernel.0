From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jan 2010 16:36:58 +0000
Subject: [PATCH 1/2] arm/at91: Don't disable irqs in set_next_event and
	set_mode callbacks
In-Reply-To: <20100122160824.GA13718@pengutronix.de>
References: <1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1261056821-28521-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100122160824.GA13718@pengutronix.de>
Message-ID: <20100122163658.GA18461@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2010 at 05:08:24PM +0100, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> I havn't got any more feedback but I think these are OK after the last
> comments.  Do you take them?
> 
> You can pull them from
> 
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git arm/clock-event

I really don't like pulling git urls which I don't know what I'm pulling.
Please include at least a diffstat and shortlog of the commits you're
expecting to be sent.

Something like the output from git request-pull would be ideal.
