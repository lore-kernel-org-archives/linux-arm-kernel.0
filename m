From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 11:30:38 +0100
Subject: [PATCH] ARM: Versatile Express: Add default memory layout
In-Reply-To: <20100721165509.26047.70564.stgit@e102109-lin.cambridge.arm.com>
References: <20100721165509.26047.70564.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100722103038.GE31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 05:55:09PM +0100, Catalin Marinas wrote:
> Since this platform is known to have 1GB of RAM at 0x60000000, add a
> .fixup function to set the defaults in case no "mem=" option is passed
> on the kernel command line.

And the reason why uboot can't pass the RAM information to the kernel is...
