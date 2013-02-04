From: balbi@ti.com (Felipe Balbi)
Date: Mon, 4 Feb 2013 21:53:15 +0200
Subject: [RFC/PATCH 29/32] usb: gadget: pxa27x_udc: let udc-core manage
 gadget->dev
In-Reply-To: <87txq1m57u.fsf@free.fr>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
 <1359042370-4358-30-git-send-email-balbi@ti.com>
 <87txq1m57u.fsf@free.fr>
Message-ID: <20130204195315.GA29628@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 09:18:29PM +0100, Robert Jarzmik wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > By simply setting a flag, we can drop some
> > boilerplate code.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/usb/gadget/pxa27x_udc.c | 9 +--------
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> And I tested also your patch and it works in my environment. For next patches
> I'd like to be CCed for pxa27x_udc stuff as I'm maintaining that one since its
> beginning (and yes, I know, I didn't put that in MAINTAINERS ...).

you should add yourself to MAINTAINERS. Please send a patch to Greg when
you have time.

No need to prepare a tree, though. I just need you to give your Acked-by
and I'll queue the patches myself.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/ad6a8247/attachment.sig>
