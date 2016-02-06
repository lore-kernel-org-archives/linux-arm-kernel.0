From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 06 Feb 2016 22:57:39 +0100
Subject: [PATCH v2 20/51] mtd: docg3: switch to mtd_ooblayout_ops
In-Reply-To: <1454580434-32078-21-git-send-email-boris.brezillon@free-electrons.com>
 (Boris Brezillon's message of "Thu, 4 Feb 2016 11:06:43 +0100")
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
 <1454580434-32078-21-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <87y4ax33jg.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> Replace the nand_ecclayout definition by the equivalent mtd_ooblayout_ops
> definition.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
