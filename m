From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 31 Jan 2013 21:28:30 -0500 (EST)
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <510AEDC2.80107@zytor.com>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
 <20130129101549.GP23505@n2100.arm.linux.org.uk> <51089523.3080804@zytor.com>
 <alpine.LFD.2.02.1301301326530.6300@xanadu.home> <510AE6BF.4080303@zytor.com>
 <alpine.LFD.2.02.1301311700470.6300@xanadu.home> <510AEDC2.80107@zytor.com>
Message-ID: <alpine.LFD.2.02.1301312117240.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Jan 2013, H. Peter Anvin wrote:

> On 01/31/2013 02:16 PM, Nicolas Pitre wrote:
> >>
> >> Some utterly weird things like the Xen domain builder do that, because
> >> they have to.  That is why we explicitly document that the payload is
> >> ELF and how to access it in the bzImage spec.
> > 
> > Are you kidding?
> > 
> > And what format do they expect?
> > 
> 
> I think they can be fairly flexible.  Obviously gzip is always
> supported.  I don't know the details.
> 
> > If people are doing weird things with formats we're about to remove then 
> > it's their fault if they didn't make upstream developers aware of it.  
> > And if the reason they didn't tell anyone is because it is too nasty for 
> > public confession then they simply deserve to be broken and come up with 
> > a more sustainable solution.
> 
> Well, it is too nasty for public confession, but it's called
> "paravirtualization".

The fact that you are aware of it means we're not going to break them.  

But my point is that we must not be held back just in case someone out 
there might have painted himself in a corner without telling anyone.


Nicolas
