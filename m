From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Jul 2013 11:12:53 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <20130728085650.GA4683@netboy>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1441731.8CGUI1tUxh@flatron> <20130728085650.GA4683@netboy>
Message-ID: <1416484.XDfk5G56BI@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 of July 2013 10:56:52 Richard Cochran wrote:
> On Sat, Jul 27, 2013 at 11:51:06AM -0700, Tomasz Figa wrote:
> > On Saturday 27 of July 2013 20:31:01 Richard Cochran wrote:
> > > Frankly, I am really surprised and shocked at the cavalier attitude
> > > expressed here WRT DT bindings in released kernels. Think about the
> > > *users* of this code. Not everyone working with ARM Linux is a
> > > kernel
> > > developer or a DT guru. There is really no indication at all that
> > > the
> > > ARM Linux DT stuff released so far are not stable and trustworthy.
> 
> Read the above again, please.

I'm not really sure what effect on users this has. Maybe you should define 
"users".

Sure, if you don't like the fact that it is not cleary said, whether we 
use a) or b) (see below), then it's hard to disagree with you - it should 
have been said. We are trying to fix this now.

> > Well, it depends on how we use the DT. There are (at least) two
> > possible> 
> > usage scenarios:
> >  a) using DT as direct replacement for board files - this means that
> >  you
> >  
> >     are free to say that DTSes are strictly coupled with kernel
> >     version
> >     and you are free to modify the bindings - see the analogy to board
> >     files, where you could modify the platform data structures and
> >     could
> >     not directly copy board file from one kernel version to another,
> >  
> >  b) using DT as an ABI - this is the original way, i.e. define stable
> >  
> >     bindings and make sure that anu DTB built for older kernel will
> >     work,
> >     with equal or greater set of functionality on newer kernels.
> > 
> > Now I believe in this thread the point whether we should use a) or b)
> > or a combination of both has been raised.
> 
> If you seriously want to pursue a) then you are thinking only of
> yourself.
> 
> Please consider the needs of the people trying to use your code in
> actual practice.

Care to explain this reasoning?

Let's say I'm not strongly for neither of above and I'd like you to 
convince me to one of the options.

Best regards,
Tomasz
