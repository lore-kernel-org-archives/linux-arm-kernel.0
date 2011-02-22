From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Feb 2011 20:15:29 +0000
Subject: [PATCHv3] amba: support pm ops
In-Reply-To: <201102222102.15089.rjw@sisk.pl>
References: <201102212126.10742.rjw@sisk.pl>
	<1298353261-22193-1-git-send-email-rabin.vincent@stericsson.com>
	<201102222102.15089.rjw@sisk.pl>
Message-ID: <20110222201529.GB29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 09:02:14PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, February 22, 2011, Rabin Vincent wrote:
> > Support pm_ops in the AMBA bus, required to allow drivers to use runtime pm.
> > The implementation of AMBA bus pm ops is based on the platform bus
> > implementation.
> > 
> > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> 
> Looks good.
> 
> Who's supposed to take it?

Does this help?

ARM PRIMECELL BUS SUPPORT
M:      Russell King <linux@arm.linux.org.uk>
S:      Maintained
F:      drivers/amba/
F:      include/linux/amba/bus.h
