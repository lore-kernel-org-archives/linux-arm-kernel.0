From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 22 May 2013 22:31:55 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522193629.GA18344@obsidianresearch.com>
References: <20130522170643.54a2b9d2@skate> <201305221735.11815.arnd@arndb.de>
 <20130522180842.7edcc3ee@skate> <20130522163557.GC27348@1wt.eu>
 <20130522184250.1d5f2f10@skate>
 <20130522164936.GE31290@titan.lakedaemon.net>
 <20130522185757.60091a66@skate>
 <20130522181953.GD12320@obsidianresearch.com>
 <20130522185521.GR26249@lunn.ch>
 <20130522193629.GA18344@obsidianresearch.com>
Message-ID: <20130522203155.GT26249@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So, as bootloaders get updated to support native DTB, how do you
> envision supporting that through flash-kernel? The way to set the DTB
> is bootloader version dependent..

You need to ask the Debian people. But my guess is, they will keep
appending the DTB blob to the kernel. They then have control of it in
an easy way. I've no idea what happens if there is both an appended
blob and one passed by the boot loader. I've not yet actually seen a
kirkwood u-boot which supports DT on COTS hardware. So it may never
actually come to pass, except for machines in the hands of kernel
hackers who update the bootloader.

	Andrew
