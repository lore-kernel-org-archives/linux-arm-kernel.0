From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 May 2012 16:09:32 +0100
Subject: [PATCH] ARM: mv78xx0: Fix compiler error in pcie.c
In-Reply-To: <1337180719-5655-1-git-send-email-andrew@lunn.ch>
References: <1337180719-5655-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120516150932.GG9571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 05:05:19PM +0200, Andrew Lunn wrote:
> arch/arm/mach-mv78xx0/pcie.c:256:29: error: 'bus' undeclared (first use in this function)
> 
> caused by the patch:
> 
> ARM: PCI: dove/kirkwood/mv78xx0: use sys->private_data

I've already merged my fix into the original commit in my pci branch
after you reported the problem in private.

Thanks.
