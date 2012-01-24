From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 24 Jan 2012 22:23:11 +0100
Subject: [PATCH 21/31] ARM: amba: realview: get rid of private platform
 amba_device initializer
In-Reply-To: <20120124172600.GO19798@mudshark.cambridge.arm.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk>
 <20120124160044.GM19798@mudshark.cambridge.arm.com>
 <20120124162328.GA8517@n2100.arm.linux.org.uk>
 <20120124172600.GO19798@mudshark.cambridge.arm.com>
Message-ID: <4F1F213F.9070106@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2012 06:26 PM, Will Deacon wrote:
>
> Right. I took a quick look at the TRM for the PB1176, and I think we do have
> an interrupt for GPIO0, it's just on the other GIC. This patch should do the
> trick, but I'm not sure what I can do to tickle the GPIO stuff anyway:

For a simple test just insert/remove the MMC card and see it
add/remove the card (appear in console, and /proc/interrupts)

Or do you mean tickle GPIO0? That is more tricky I think...

Yours,
Linus Walleij
