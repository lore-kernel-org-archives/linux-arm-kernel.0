From: colin.tuckley@arm.com (Colin Tuckley)
Date: Mon, 24 Jan 2011 09:05:35 -0000
Subject: [PATCH] Realview: name configuration options after actual board
	names
In-Reply-To: <AANLkTimvvNCNsViqs4_=sXB0+HqzdTZkuD5Hc5U18UQc@mail.gmail.com>
References: <20110122183038.GA11960@n2100.arm.linux.org.uk>
	<AANLkTimvvNCNsViqs4_=sXB0+HqzdTZkuD5Hc5U18UQc@mail.gmail.com>
Message-ID: <000001cbbba5$dcc88d80$9659a880$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: catalin.marinas at gmail.com [mailto:catalin.marinas at gmail.com] On

> On Saturday, 22 January 2011, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > I haven't significantly updated the descriptions for the tiles as
> that
> > is even less clear - as far as I can see on ARMs website, there is no
> > Cortex-A9 tile for Realview EB - only ARM11MPCore, ARM1156T2F-S,
> > ARM1176TZF-S and Cortex-R4F.  So exactly what this 'Multicore Cortex-
> A9
> > Tile' is..
> 
> AFAIK there isn't any official A9 tile for EB. this configuration has
> been used in processor validation and also on the ARMv7 software
> models, that's why we pushed this option. You can remove it if you
> want, we'll probably keep it around in our patches.

No, please do *not* delete it. It is used by one of the emulation platforms.

Colin
