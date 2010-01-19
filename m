From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2010 08:54:44 +0000
Subject: [PATCH] arm: remove support for old way to pass kernel parameters
In-Reply-To: <1263890623-14952-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100119083803.GA17904@pengutronix.de>
	<1263890623-14952-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100119085444.GB24447@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 09:43:43AM +0100, Uwe Kleine-K?nig wrote:
> This was deprecated in 2001 and announced to live on for 5 years.

Unfortunately, there are still boot loaders around which use the old
way (eg, my firewall and server machines) - maybe make it a config
option for the time being.
