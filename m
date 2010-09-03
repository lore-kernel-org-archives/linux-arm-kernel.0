From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Sep 2010 08:42:47 +0100
Subject: [PATCH] ARM: SAMSUNG: Removed redunt zreladdr in Makefile.boot
In-Reply-To: <1283470043-16050-1-git-send-email-kgene.kim@samsung.com>
References: <1283470043-16050-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100903074247.GG26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 03, 2010 at 08:27:23AM +0900, Kukjin Kim wrote:
> Because can be calculated ZREADDR now, removed redunt zreladdr
> definitions in each Makefile.boot of Samsung architectures.

I'd suggest holding off on this.  CONFIG_ZRELADDR has a few problems
at the moment that need fixing - and if there's no movement to fix
them, it'll be reverted.
