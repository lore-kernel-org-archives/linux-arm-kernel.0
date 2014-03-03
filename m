From: balbi@ti.com (Felipe Balbi)
Date: Mon, 3 Mar 2014 10:47:29 -0600
Subject: [PATCH] usb: gadget: atmel_usba: fix crash when no endpoint are
 specified
In-Reply-To: <20140303164633.GB3155@piout.net>
References: <1393515733-15764-1-git-send-email-alexandre.belloni@free-electrons.com>
 <53109EBE.4020900@atmel.com> <20140303164633.GB3155@piout.net>
Message-ID: <20140303164729.GE10987@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 05:46:34PM +0100, Alexandre Belloni wrote:
> Hi Felipe,
> 
> On 28/02/2014 at 15:35:42 +0100, Nicolas Ferre wrote :
> > On 27/02/2014 16:42, Alexandre Belloni :
> > > If no endpoints are present in the device tree, the kernel will cras hwith the
> > 
> > s/cras hwith/crash with/
> > 
> 
> Do you want me to send a v2 with that typo corrected or could you
> correct it when applying ?

I'll fix it up, don't worry.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/cf825cde/attachment.sig>
