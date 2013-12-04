From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 4 Dec 2013 12:48:54 +0000
Subject: [PATCH] ARM: mcpm: Make all mcpm functions notrace
In-Reply-To: <529EEAEF.1040206@samsung.com>
References: <1385976547.3387.2.camel@linaro1.home>
 <20131202172531.GB2312@e103592.cambridge.arm.com>
 <529EEAEF.1040206@samsung.com>
Message-ID: <20131204124847.GA2323@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 12:42:23PM +0400, Tarek Dakhran wrote:
> Hi, Dave!
> 
> On 12/02/2013 09:25 PM, Dave Martin wrote:
> >Vyacheslav, Tarek, can you add the corresponding change in your Exynos
> >Dual Cluster support code please?
> >
> >There's no need for it to be a separate patch, you can simply add
> >the CFLAGS_REMOVE_ definitions alongside the other Makefile additions
> >for edcs.  If you want to be more fine-grained, you could mark
> >individual functions notrace instead -- but that may just add effort
> >and not be very useful.
> >

[...]

> 
> Will be done in next version.

Thanks
---Dave
