From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 29 Aug 2016 21:59:48 +0200
Subject: [PATCH] ARM: pxa: Use kmalloc_array() in pxa_pm_init()
In-Reply-To: <49864e7d-f786-9739-6d8c-4480ce228830@users.sourceforge.net> (SF
 Markus Elfring's message of "Thu, 25 Aug 2016 18:07:05 +0200")
References: <49864e7d-f786-9739-6d8c-4480ce228830@users.sourceforge.net>
Message-ID: <8760qje47f.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SF Markus Elfring <elfring@users.sourceforge.net> writes:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 25 Aug 2016 18:01:37 +0200
>
> * A multiplication for the size determination of a memory allocation
>   indicated that an array data structure should be processed.
>   Thus use the corresponding function "kmalloc_array".
>
>   This issue was detected by using the Coccinelle software.
>
> * Replace the specification of a data type by a pointer dereference
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Queued to pxa/for-next, thanks.

Cheers.

--
Robert
