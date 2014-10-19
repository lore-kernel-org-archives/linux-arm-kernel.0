From: balbi@ti.com (Felipe Balbi)
Date: Sun, 19 Oct 2014 10:24:14 -0500
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141019100739.GA2547@amd>
References: <20141019090107.GA19132@amd>
 <20141019100739.GA2547@amd>
Message-ID: <20141019152414.GB5189@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 19, 2014 at 12:07:39PM +0200, Pavel Machek wrote:
> On Sun 2014-10-19 11:01:07, Pavel Machek wrote:
> > Hi!
> > 
> > From 3.6 to 3.10, USB networking works on Nokia N900. With 3.11, it
> > fails with messages on the host. I also tried to get it to work on
> > 3.14 and 3.17, with no luck.
> > 
> > Any ideas? Does it work for you? Any config options to watch for?
> 
> With 3.17, I get
> 
> omap_musb_mailbox: musb core is not yet ready
> 
> message. It looks related...?

is musbmhdrc.ko loaded ? Do you have a gadget driver loaded ?

+ Aaro

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141019/46b36511/attachment.sig>
