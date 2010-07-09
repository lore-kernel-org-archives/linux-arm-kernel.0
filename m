From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jul 2010 11:16:57 +0100
Subject: [PATCH] Versatile Express: add support for local timers on
	CA9X4 daughterboard
In-Reply-To: <1275904430-15995-1-git-send-email-will.deacon@arm.com>
References: <1275904430-15995-1-git-send-email-will.deacon@arm.com>
Message-ID: <20100709101657.GB22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 07, 2010 at 10:53:50AM +0100, Will Deacon wrote:
> This patch adds support for the Cortex-A9 local timers available when
> using the CA9X4 daughterboard with the Versatile Express.

I'd rather we didn't change the timer stuff like this - all that you
seem to want is some way to setup the twd base address.  Can this be
done via .map_io method instead?
