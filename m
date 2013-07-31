From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 31 Jul 2013 09:53:46 -0400
Subject: [Ksummit-2013-discuss] [ATTEND] [ARM ATTEND] kernel data bloat
 and how to avoid it
In-Reply-To: <20130731123351.GA30474@kroah.com>
References: <20130731073802.GT7656@atomide.com>
 <20130731123351.GA30474@kroah.com>
Message-ID: <20130731135346.GN5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 05:33:51AM -0700, Greg KH wrote:
> On Wed, Jul 31, 2013 at 12:38:03AM -0700, Tony Lindgren wrote:
> > Hi all,
> > 
> > Probably the biggest kernel data bloat issue is in the ARM land, but
> > it also seems that it's becoming a Linux generic issue too, so I
> > guess it could be discussed in either context.
> 
> Why is it specific to ARM?  What is so unique to ARM that causes it to
> "bloat"?
> 
> And what exactly do you mean by "bloat"?

Perhaps he's referring to the multiplatform effort?  You'd get a lot of
board code that wouldn't be used at each boot.  This should be declining
though...

thx,

Jason.
