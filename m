From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 21 May 2014 09:01:47 -0400
Subject: [PATCH 2/2] documentation/devicetree: Update GIC compat strings
In-Reply-To: <20140521102439.GE17827@leverpostej>
References: <1400664501-4208-1-git-send-email-Nikolay.Borisov@arm.com>
 <1400664501-4208-3-git-send-email-Nikolay.Borisov@arm.com>
 <20140521102439.GE17827@leverpostej>
Message-ID: <20140521130147.GH8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nikolay,

On Wed, May 21, 2014 at 11:24:39AM +0100, Mark Rutland wrote:
> [Adding devicetree at vger.kernel.org]
> 
> On Wed, May 21, 2014 at 10:28:21AM +0100, Nikolay Borisov wrote:
> > Document the addition of 2 new, implementation-agnostic compatible
> > strings. This allows for more flexibility such that new implementation 
> > can either state whether they are an extension of an existing implementation,
> > a brand new implementation or just that they conform to a standard revision
> > of the GIC spec.
> 
> From my POV it makes sense to have these to make it possible to write
> DTs with new GIC variants which are implementations of the standard
> rather than extensions of existing implementations.
> 
> However, DTs using these should also state exactly what variant they
> are, and those strings should be documented (even if not supported
> directly by the driver). It would be nice to have that mentioned in the
> commit message.

Please tweak the commit message as Mark suggested and resend, including
me in the Cc.  I'll queue it up for tglx.

> Otherwise:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 

Also, please include Mark's Acks.

thx,

Jason.
