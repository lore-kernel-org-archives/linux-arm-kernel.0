From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 05 Jul 2018 21:32:31 +0200
Subject: [PATCH 8/8] mtd: rawnand: plat_nand: Kill pdata->ctrl.{hwcontrol,
 read_byte}()
In-Reply-To: <20180705102733.29673-9-boris.brezillon@bootlin.com> (Boris
 Brezillon's message of "Thu, 5 Jul 2018 12:27:33 +0200")
References: <20180705102733.29673-1-boris.brezillon@bootlin.com>
 <20180705102733.29673-9-boris.brezillon@bootlin.com>
Message-ID: <878t6ph41c.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> None of the board files are overloading those hooks, so let's drop them
> from struct platform_nand_ctrl.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
For mach-pxa :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
