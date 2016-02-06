From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 06 Feb 2016 22:55:05 +0100
Subject: [PATCH v2 18/51] mtd: docg3: use mtd_set_ecclayout() where
 appropriate
In-Reply-To: <1454580434-32078-19-git-send-email-boris.brezillon@free-electrons.com>
 (Boris Brezillon's message of "Thu, 4 Feb 2016 11:06:41 +0100")
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
 <1454580434-32078-19-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <8737t54i86.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> Use the mtd_set_ecclayout() helper instead of directly assigning the
> mtd->ecclayout field.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
