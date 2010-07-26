From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Jul 2010 10:28:55 +0100
Subject: Pull request mxc
In-Reply-To: <20100726090014.GQ14113@pengutronix.de>
References: <20100726090014.GQ14113@pengutronix.de>
Message-ID: <20100726092855.GA20737@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 26, 2010 at 11:00:14AM +0200, Sascha Hauer wrote:
>  160 files changed, 6547 insertions(+), 3276 deletions(-)

I get:

160 files changed, 6530 insertions(+), 3265 deletions

which seems to be down to this difference between your diffstat and mine:

> arch/arm/mach-mx3/mach-mx31lilly.c                 |   48 +-

 arch/arm/mach-mx3/mach-mx31lilly.c                 |   20 +-

This seems to be down to 4d5d859 (ARM: mx3: mx31lilly: fix build error for
!CONFIG_USB_ULPI).
