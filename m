From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Sep 2010 15:06:52 +0100
Subject: [RFC] SoC name and revision in /proc/cpuinfo
In-Reply-To: <20100924135356.GA17651@game.jcrosoft.org>
References: <20100924135356.GA17651@game.jcrosoft.org>
Message-ID: <20100924140652.GA14809@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 24, 2010 at 03:53:56PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Hi Russell,
> 
> 	On AT91 for some userland library we need to known the cpu model and revision
> 	so I'd like to known if it's ok with you to extend it?
> 
> 	as
> 	cpu familly:	at91
> 	cpu type:	at91sam9g20
> 	cpu revision:	1.1

You're mixing up the CPU with the SoC.  The CPU is what's in the core of
the SoC and has no peripherals etc.  The SoC is the entire chip.  "Central
Processing Unit."  "System on a Chip."

I'd much rather see SoC information kept separate from the CPU information.
