From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Aug 2012 15:20:49 -0400
Subject: [PATCH] arm: add documentation describing Marvell families of SoC
In-Reply-To: <1344115004-7886-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344115004-7886-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120814192049.GR22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 04, 2012 at 11:16:44PM +0200, Thomas Petazzoni wrote:
> As stated in the introduction of the document, the families of ARM
> SoCs at Marvell are very complicated, and it is difficult for
> newcomers to understand the organization of this SoC family and how it
> relates to the Linux kernel support for those hardware platforms.
> 
> This document is only at RFC stage for now, it requires reviews and
> comments from the Marvell maintainers, the PXA maintainers and the MMP
> maintainers. For correctness of course, but also to add any other
> information that would be useful. For example, one of the thing that
> wasn't clear how to detail in the documentation is how the SoCs relate
> to each other in terms of hardware IP blocks. For example, most of the
> Kirkwood/Dove/Armada 370-XP/etc. hardware IPs (I2C, SPI, USB, SATA,
> etc.) are identical, while the PXA and MMP families are completely
> separate.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Lior Amsalem <alior@marvell.com>
> Cc: Maen Suleiman <maen@marvell.com>
> Cc: Tawfik Bayouk <tawfik@marvell.com>
> Cc: Shadi Ammouri <shadi@marvell.com>
> Cc: Eran Ben-Avi <benavi@marvell.com>

Added Arnd's Acked-by: and applied to:

git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7

thx,

Jason.
