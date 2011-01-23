From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Jan 2011 15:55:49 +0000
Subject: [PATCH] Realview: name configuration options after actual
	board names
In-Reply-To: <AANLkTimvvNCNsViqs4_=sXB0+HqzdTZkuD5Hc5U18UQc@mail.gmail.com>
References: <20110122183038.GA11960@n2100.arm.linux.org.uk>
	<AANLkTimvvNCNsViqs4_=sXB0+HqzdTZkuD5Hc5U18UQc@mail.gmail.com>
Message-ID: <20110123155549.GF30094@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 11:02:30AM +0000, Catalin Marinas wrote:
> On Saturday, 22 January 2011, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > I haven't significantly updated the descriptions for the tiles as that
> > is even less clear - as far as I can see on ARMs website, there is no
> > Cortex-A9 tile for Realview EB - only ARM11MPCore, ARM1156T2F-S,
> > ARM1176TZF-S and Cortex-R4F. ?So exactly what this 'Multicore Cortex-A9
> > Tile' is..
> 
> AFAIK there isn't any official A9 tile for EB. this configuration has
> been used in processor validation and also on the ARMv7 software
> models, that's why we pushed this option. You can remove it if you
> want, we'll probably keep it around in our patches.

But otherwise that's an ack for the patch?
