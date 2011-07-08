From: balbi@ti.com (Felipe Balbi)
Date: Sat, 9 Jul 2011 00:54:43 +0300
Subject: [PATCH 07/15] pxa25x_udc: drop support for udc_command
In-Reply-To: <20110708213428.GA31866@kroah.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
	<1309871321-11305-8-git-send-email-dbaryshkov@gmail.com>
	<20110705134615.GJ2820@legolas.emea.dhcp.ti.com>
	<20110708213428.GA31866@kroah.com>
Message-ID: <20110708215442.GG31978@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 02:34:28PM -0700, Greg KH wrote:
> On Tue, Jul 05, 2011 at 04:46:16PM +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Tue, Jul 05, 2011 at 05:08:33PM +0400, Dmitry Eremin-Solenikov wrote:
> > > None of pxa25x devices use udc_command() for UDC functionality.
> > > Stop calling this callback from pxa25x_udc code.
> > 
> > looks good to me, Greg since this is a big re-work which depends on
> > parts out of the Gadget Framework, can you take all the patches
> > straight ? Here's my Acked-by:
> > 
> > Acked-by: Felipe Balbi <balbi@ti.com>
> 
> I can't take these, they should go through the gpio subsystem maintainer
> instead.

But why ? They only touch drivers/usb/gadget/pxa*.c

Would it be enough if Grant would Ack them ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110709/c10b73d3/attachment-0001.sig>
