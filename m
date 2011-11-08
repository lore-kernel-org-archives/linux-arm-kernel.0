From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 08 Nov 2011 10:13:12 +0200
Subject: OMAP CRAP: The Continuing Story Of Brokenness
In-Reply-To: <20111107202620.GW31337@atomide.com>
References: <20111106121829.GB15294@n2100.arm.linux.org.uk>
 <20111107172600.GS31337@atomide.com>
 <20111107174645.GE15294@n2100.arm.linux.org.uk>
 <20111107202620.GW31337@atomide.com>
Message-ID: <1320739992.1907.34.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, 2011-11-07 at 12:26 -0800, Tony Lindgren wrote:
> Tomi,
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111107 09:12]:
> 
> > drivers/video/omap/dispc.c:276: warning: data definition has no type or storage class
> > drivers/video/omap/dispc.c:276: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> > drivers/video/omap/dispc.c:276: warning: parameter names (without types) in function declaration
> > drivers/video/omap/dispc.c:286: warning: data definition has no type or storage class
> > drivers/video/omap/dispc.c:286: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> > drivers/video/omap/dispc.c:286: warning: parameter names (without types) in function declaration
> > drivers/video/omap/dispc.c:320: warning: data definition has no type or storage class
> > drivers/video/omap/dispc.c:320: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> > drivers/video/omap/dispc.c:320: warning: parameter names (without types) in function declaration
> > drivers/video/omap/dispc.c:328: warning: data definition has no type or storage class
> > drivers/video/omap/dispc.c:328: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> > drivers/video/omap/dispc.c:328: warning: parameter names (without types) in function declaration
> > drivers/video/omap/dispc.c:863: warning: data definition has no type or storage class
> > drivers/video/omap/dispc.c:863: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> > drivers/video/omap/dispc.c:863: warning: parameter names (without types) in function declaration
> > drivers/video/omap/dispc.c:883: warning: data definition has no type or storage class
> > drivers/video/omap/dispc.c:883: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> > drivers/video/omap/dispc.c:883: warning: parameter names (without types) in function declaration
> 
> Care to queue something for drivers/video/omap warnings above?

Sure, I'll send a patch for -rc2. 

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111108/f63af45c/attachment.sig>
