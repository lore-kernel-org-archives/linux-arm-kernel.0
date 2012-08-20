From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Aug 2012 10:44:55 +0100
Subject: restart callback not supposed to sleep?
In-Reply-To: <20120820092145.GM2232@pengutronix.de>
References: <20120820082423.GJ2232@pengutronix.de>
 <20529.64510.403690.325993@ipc1.ka-ro>
 <20120820090546.GR18957@n2100.arm.linux.org.uk>
 <20120820092145.GM2232@pengutronix.de>
Message-ID: <20120820094455.GS18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 11:21:45AM +0200, Uwe Kleine-K?nig wrote:
> Just for the log: The restart works ok.

Restart with a command or restart with sysrq ?
