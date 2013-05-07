From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 7 May 2013 14:34:59 +0100
Subject: [Xen-devel] [PATCH RFC v2 2/4] arm: introduce CONFIG_PARAVIRT
 and pv_time_ops
In-Reply-To: <1367931376.26321.117.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1305061532310.4756@kaball.uk.xensource.com>
 <1367851878-21629-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <1367918609.26321.43.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1305071301040.4147@kaball.uk.xensource.com>
 <1367931376.26321.117.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1305071433560.4147@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 May 2013, Ian Campbell wrote:
> On Tue, 2013-05-07 at 13:15 +0100, Stefano Stabellini wrote:
> > On Tue, 7 May 2013, Ian Campbell wrote:
> > > On Mon, 2013-05-06 at 15:51 +0100, Stefano Stabellini wrote:
> > > > Introduce CONFIG_PARAVIRT on ARM.
> > > 
> > > What about PARAVIRT_TIME_ACCOUNTING? I'm not sure what it is but it
> > > looks like a more lightweight version of pv stolen time?
> >  
> > PARAVIRT_TIME_ACCOUNTING selects PARAVIRT on x86 :-)
> 
> Ah, that's maybe what confused me.
> 
> TBH its not at all clear to me what distinction the core code is trying
> to make with those two options, but do we not also want/need
> PARAVIRT_TIME_ACCOUNTING? Having reread the help text it seems to be
> some sort of "more accurate" accounting?

It is not clear to me either.
I think that you are right, we probably want PARAVIRT_TIME_ACCOUNTING too.
