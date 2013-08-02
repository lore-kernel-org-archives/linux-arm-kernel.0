From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 00:55:15 -0700
Subject: [Ksummit-2013-discuss] [ATTEND] [ARM ATTEND] kernel data bloat
 and how to avoid it
In-Reply-To: <20130731135346.GN5882@titan.lakedaemon.net>
References: <20130731073802.GT7656@atomide.com>
 <20130731123351.GA30474@kroah.com>
 <20130731135346.GN5882@titan.lakedaemon.net>
Message-ID: <20130802075514.GZ7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jason Cooper <jason@lakedaemon.net> [130731 07:00]:
> On Wed, Jul 31, 2013 at 05:33:51AM -0700, Greg KH wrote:
> > On Wed, Jul 31, 2013 at 12:38:03AM -0700, Tony Lindgren wrote:
> > > Hi all,
> > > 
> > > Probably the biggest kernel data bloat issue is in the ARM land, but
> > > it also seems that it's becoming a Linux generic issue too, so I
> > > guess it could be discussed in either context.
> > 
> > Why is it specific to ARM?  What is so unique to ARM that causes it to
> > "bloat"?
> > 
> > And what exactly do you mean by "bloat"?
> 
> Perhaps he's referring to the multiplatform effort?  You'd get a lot of
> board code that wouldn't be used at each boot.  This should be declining
> though...

Yes that too, device tree and ACPI help there a great deal as we don't
need to build in board specific data for each supported board, but
instead have just one copy of the board specific data come from the
bootloader.

Regards,

Tony
