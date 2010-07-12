From: pieterg@gmx.com (pieterg)
Date: Mon, 12 Jul 2010 10:37:13 +0200
Subject: [PATCH 1/5] cpufreq-pxa3xx: use HSIO 312MHz on the pxa310
In-Reply-To: <4C396F4E.3080704@compulab.co.il>
References: <201007081904.01464.pieterg@gmx.com>
	<201007091031.44681.pieterg@gmx.com>
	<4C396F4E.3080704@compulab.co.il>
Message-ID: <201007121037.14387.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 July 2010 09:14:22 Igor Grinberg wrote:
> On 07/09/10 11:31, pieterg wrote:
> > On Friday 09 July 2010 10:02:16 Eric Miao wrote:
> >> What's wrong with 208MHz HSS on PXA310?
> >
> > I haven't done any benchmarking, but Marvell found it worth to
> > introduce 312MHz for the pxa310. (I assume it might have something to
> > do with the video accelerator, which is unique to the pxa310).
> >
> > And to me it makes sense to use the highest supported speeds in the top
> > cpufreq entry.
>
> According to Marvell's PXA3xx Specification Update document
> (page 68 - SCr#3), the above is correct starting from silicon revision
> A2. What about earlier revisions? Shouldn't we support all of them?

OK, I missed that. In that case we should leave this one out.

Rgds, Pieter
