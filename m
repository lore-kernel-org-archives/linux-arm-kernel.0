From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Dec 2014 10:38:13 -0600
Subject: [PATCH 1/2] USB: gadget: udc: atmel: change setting for DMA
In-Reply-To: <54930CE7.50008@atmel.com>
References: <1418807929-31952-1-git-send-email-voice.shen@atmel.com>
 <54930CE7.50008@atmel.com>
Message-ID: <20141222163813.GI12815@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 06:20:39PM +0100, Nicolas Ferre wrote:
> Le 17/12/2014 10:18, Bo Shen a ?crit :
> > According to the datasheet, when transfer using DMA, the control
> > setting for IN packet only need END_BUF_EN, END_BUF_IE, CH_EN,
> > while for OUT packet, need more two bits END_TR_EN and END_TR_IE
> > to be configured.
> > 
> > Signed-off-by: Bo Shen <voice.shen@atmel.com>
> 
> Seems okay, even if I am not used to these aspects:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> I would also add a "stable" tag to these patches, something like this:
> 
> Fixes: 914a3f3b3754 (USB: add atmel_usba_udc driver)
> Cc: stable at vger.kernel.org # always been there...
> 
> 
> Felipe,
> 
> Can you take both of these patches as fixes?

I'll get back to them... Still other patches to go through.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/4150c2bf/attachment.sig>
