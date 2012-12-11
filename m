From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 11 Dec 2012 16:41:53 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <alpine.DEB.2.02.1212111621220.17523@kaball.uk.xensource.com>
References: <20121204124047.GM23368@mudshark.cambridge.arm.com>
 <20121204133326.GE14363@n2100.arm.linux.org.uk>
 <20121204134010.GP23368@mudshark.cambridge.arm.com>
 <20121204143724.GF14363@n2100.arm.linux.org.uk>
 <20121204161113.GT23368@mudshark.cambridge.arm.com>
 <50BE28C6.2010403@gmail.com>
 <20121204171628.GF5314@mudshark.cambridge.arm.com>
 <50BE31E9.3040404@arm.com>
 <20121204173045.GI5314@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1212111558270.17523@kaball.uk.xensource.com>
 <20121211160956.GF16759@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1212111621220.17523@kaball.uk.xensource.com>
Message-ID: <1355244113.4683.8.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-11 at 16:34 +0000, Stefano Stabellini wrote:
> On Tue, 11 Dec 2012, Will Deacon wrote:
> > On Tue, Dec 11, 2012 at 04:04:20PM +0000, Stefano Stabellini wrote:
> > > Hi!
> > 
> > Hi Stefano,
> > 
> > > Sorry for taking so long to reply but I admit I missed the thread
> > > entirely until now. I would appreciate if you could CC
> > > xen-devel at lists.xen.org and/or me for virtualization related
> > > discussions.
> > 
> > I did CC xen-arm at lists.xen.org,
>   
> Thanks!
> I don't know why I didn't receive it then :-\

xen-arm@ is the list for the armv6 pv Xen port but those developers
aren't terribly active these days and I wouldn't be surprise if no one
is moderating that particular list. I assume Will isn't subscribed so
his post will be in the queue somewhere.

> In any case xen-devel is the right place for upstream related
> discussion.

Right, any discussion about Xen on v7 and v8 ARM processors with the
virt extensions should happen on xen-devel@ not xen-arm@, the
MAINTAINERS file reflects this.

Ian.
