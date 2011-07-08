From: balbi@ti.com (Felipe Balbi)
Date: Sat, 9 Jul 2011 01:14:29 +0300
Subject: [PATCH 07/15] pxa25x_udc: drop support for udc_command
In-Reply-To: <20110708220258.GA29651@suse.de>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
	<1309871321-11305-8-git-send-email-dbaryshkov@gmail.com>
	<20110705134615.GJ2820@legolas.emea.dhcp.ti.com>
	<20110708213428.GA31866@kroah.com>
	<20110708215442.GG31978@legolas.emea.dhcp.ti.com>
	<20110708220258.GA29651@suse.de>
Message-ID: <20110708221428.GJ31978@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 08, 2011 at 03:02:58PM -0700, Greg KH wrote:
> > > I can't take these, they should go through the gpio subsystem maintainer
> > > instead.
> > 
> > But why ? They only touch drivers/usb/gadget/pxa*.c
> 
> All 15 patches?  No they don't they touch all sorts of things.
> 
> > Would it be enough if Grant would Ack them ?
> 
> Sure, but it would be easier if Grant took them all, right?

Makes sense too.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110709/ade92949/attachment.sig>
