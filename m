From: greg@kroah.com (Greg KH)
Date: Thu, 12 May 2011 11:57:51 -0700
Subject: [PATCH] usb/gadget: at91sam9g20 fix end point max packet size
In-Reply-To: <20110512183839.GK18952@game.jcrosoft.org>
References: <20110510170500.GB15675@kroah.com>
	<20110510235324.GD18929@game.jcrosoft.org>
	<20110511015829.GB6840@kroah.com>
	<20110511031854.GF18929@game.jcrosoft.org>
	<20110511135041.GC12717@kroah.com>
	<20110512013038.GA24270@game.jcrosoft.org>
	<20110512044731.GA24746@kroah.com> <4DCBD11A.8060906@ru.mvista.com>
	<20110512150800.GE30910@kroah.com>
	<20110512183839.GK18952@game.jcrosoft.org>
Message-ID: <20110512185751.GA6525@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 08:38:39PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 08:08 Thu 12 May     , Greg KH wrote:
> > On Thu, May 12, 2011 at 04:22:50PM +0400, Sergei Shtylyov wrote:
> > > Hello.
> > > 
> > > On 12-05-2011 8:47, Greg KH wrote:
> > > 
> > > >No, I can't apply it because of the comments above Sergei.  Please fix
> > > >that and get his approval and then I will be able to apply it.
> > > 
> > >    I'm OK with applying the patch to 2.6.39 actually. If I
> > > understood correctly, the code will be reworked to get rid of
> > > cpu_is_*() for 2.6.40+...
> > 
> > It's too late for .39, sorry.
> can we have it for the stable kernel at least

Please go read Documentation/stable_kernel_rules.txt for how to get
patches into the stable kernel trees.

thanks,

greg k-h
