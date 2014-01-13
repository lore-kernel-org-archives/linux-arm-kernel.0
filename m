From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jan 2014 14:02:15 +0000
Subject: [PATCH v5 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20140113135858.GE11805@arm.com>
References: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1386686497-20335-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140102113057.GI16456@n2100.arm.linux.org.uk>
 <20140102144724.GF19878@titan.lakedaemon.net>
 <20140102145835.GA6883@localhost> <20140112145206.GD6099@localhost>
 <20140113135858.GE11805@arm.com>
Message-ID: <20140113140215.GZ15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 01:58:58PM +0000, Catalin Marinas wrote:
> On Sun, Jan 12, 2014 at 02:52:07PM +0000, Ezequiel Garcia wrote:
> > Catalin, Will: Can you ack as well, so Russell can take this?
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> (with the condition that Will promises to sort out the generic relaxed
> IO accessors and move this to generic code ;))

I think that's an impossibility, as there's no such thing as a "generic
relaxed IO accessor" and agreement on what that should be is very hard
to come by.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
