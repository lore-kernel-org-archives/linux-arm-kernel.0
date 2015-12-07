From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 7 Dec 2015 12:36:54 +0000
Subject: [RFC PATCH 0/8] CPUs capacity information for heterogeneous
 systems
In-Reply-To: <20151207121135.GN8644@n2100.arm.linux.org.uk>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <20151207120244.GE14571@e106622-lin>
 <20151207121135.GN8644@n2100.arm.linux.org.uk>
Message-ID: <20151207123654.GG14571@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/15 12:11, Russell King - ARM Linux wrote:
> On Mon, Dec 07, 2015 at 12:02:44PM +0000, Juri Lelli wrote:
> > On 23/11/15 14:28, Juri Lelli wrote:
> > > Hi all,
> > > 
> > 
> > Hi again everybody,
> > 
> > thanks a lot to Rob and Vincent for feedback, but, IMHO, we'd need more
> > discussion happening on this series to figure out how we move forward;
> > so, this is a ping :-).  It's a simple information that we need to figure
> > out how to provide, and in which form, but it has the potential to form
> > a standardized basis for achieving important performance benefits.
> 
> I'm happy to take the first patch, it looks like a simple clean up.
> Please arrange for it to land in my patch system.  Thanks.
> 

OK, will do. Thanks!

> It looks like the second patch doesn't yet have the backing from the DT
> people, which prevents the remainder of the patch set progressing.  That's
> the sticking point which needs to be resolved.
> 

Agreed. That is exactly the point for which I was seeking more feedback.
OTOH, 7/8 and 8/8 may potentially work without the DT bindings, as they
simply expose a sysfs attribute. If you, and others, see value in them,
I can easily put them at the top of the series and post a v2. Thoughts?

Best,

- Juri
