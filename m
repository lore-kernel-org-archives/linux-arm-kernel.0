From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 04 Dec 2009 17:56:55 +0100
Subject: Query about pxa27x_udc.c
In-Reply-To: <4B1909BF.9050704@cam.ac.uk> (Jonathan Cameron's message of "Fri\,
	04 Dec 2009 13\:08\:15 +0000")
References: <4B1909BF.9050704@cam.ac.uk>
Message-ID: <87638miso8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jonathan Cameron <jic23@cam.ac.uk> writes:

> Just had the following pop up in a compile of linux-next
>
>
> drivers/usb/gadget/pxa27x_udc.c: In function 'pxa_udc_irq':
> drivers/usb/gadget/pxa27x_udc.c:2232: warning: array subscript is above array bounds
> drivers/usb/gadget/pxa27x_udc.c:2232: warning: array subscript is above array bounds
> drivers/usb/gadget/pxa27x_udc.c:2233: warning: array subscript is above array bounds

Yes, recent gcc complains.
There is a patch from Enrico Scholz, I resent it in another mail.

Cheers.

--
Robert
