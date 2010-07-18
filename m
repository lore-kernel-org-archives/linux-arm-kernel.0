From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Jul 2010 20:47:20 +0100
Subject: [PATCH] ARM: expose PB1176 ROM in debugfs
In-Reply-To: <1278504339-26992-1-git-send-email-triad@df.lth.se>
References: <1278504339-26992-1-git-send-email-triad@df.lth.se>
Message-ID: <20100718194720.GE24707@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 07, 2010 at 02:05:39PM +0200, Linus Walleij wrote:
> This exposes the PB1176 ROM as a simple 16KiB file in debugfs so
> that it can be copied out and disassembled with some
> objcopy+objdump massage for example. I used this to find out how
> the ROM handled the CharLCD.

Would it be better to expose this through a mtd ROM mapping (map_rom) ?
