From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 28 Jan 2013 21:18:29 +0100
Subject: [RFC/PATCH 29/32] usb: gadget: pxa27x_udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-30-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Thu, 24 Jan 2013 17:46:07 +0200")
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
 <1359042370-4358-30-git-send-email-balbi@ti.com>
Message-ID: <87txq1m57u.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> By simply setting a flag, we can drop some
> boilerplate code.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/gadget/pxa27x_udc.c | 9 +--------
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

And I tested also your patch and it works in my environment. For next patches
I'd like to be CCed for pxa27x_udc stuff as I'm maintaining that one since its
beginning (and yes, I know, I didn't put that in MAINTAINERS ...).

Cheers.

--
Robert
