From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 16 Sep 2013 11:08:35 +0300
Subject: [PATCH 6/6] video: drop code for ARCH_SHARK in cyber2000fb
In-Reply-To: <1379069656-4273-1-git-send-email-linus.walleij@linaro.org>
References: <1379069656-4273-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5236BC83.1020406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13/09/13 13:54, Linus Walleij wrote:
> The Cyber2000 frame buffer driver contains a block of code solely
> for the Shark machine. As the machine is deleted, delete this
> code as well.
> 
> Also remove the pointless #ifdef CONFIG_PCI as the Kconfig
> clearly states PCI as a dependency anyway.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Jean-Christophe/Tomi, I am seeking an ACK to take this through
> the ARM SoC tree as part of the deletion of the Shark machine.
> Please do not apply it to your tree.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130916/eb2a4578/attachment.sig>
