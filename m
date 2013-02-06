From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 6 Feb 2013 07:22:37 +0100
Subject: [PATCH v5 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <1592206.QUWhA9cOzT@vostro.rjw.lan>
References: <1360094115-14999-1-git-send-email-andrew@lunn.ch>
 <1360094115-14999-2-git-send-email-andrew@lunn.ch>
 <1592206.QUWhA9cOzT@vostro.rjw.lan>
Message-ID: <20130206062237.GE20212@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 10:45:38PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, February 05, 2013 08:55:13 PM Andrew Lunn wrote:
> > The Marvell Kirkwood SoCs have simple cpufreq support in hardware. The
> > CPU can either use the a high speed cpu clock, or the slower DDR
> > clock. Add a driver to swap between these two clock sources.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> This has been ACKed by Viresh already IIRC, right?

Yes, it has. Also the ARM parts have been asked by Jason Cooper.

However, the changes to the clocks are not that small....

	 Andrew
