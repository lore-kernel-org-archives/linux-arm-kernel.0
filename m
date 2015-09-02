From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 02 Sep 2015 08:17:13 +0200
Subject: [PATCH] ARM: pxa: balloon3: Fix build error
In-Reply-To: <1441072341.12012.0.camel@ingics.com> (Axel Lin's message of
 "Tue, 01 Sep 2015 09:52:21 +0800")
References: <1441072341.12012.0.camel@ingics.com>
Message-ID: <87a8t5z6om.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Axel Lin <axel.lin@ingics.com> writes:

> irq_data_get_chip() function does not exist, call irq_desc_get_chip()
> instead.
>
> Fixes: 9ec97561aa6d ("ARM/pxa: Prepare balloon3_irq_handler for irq argument removal")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
I'll take that through pxa/fixes, thanks.

Cheers.

--
Robert
