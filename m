From: juri.lelli@arm.com (Juri Lelli)
Date: Tue, 30 Aug 2016 17:11:58 +0100
Subject: [PATCH v6 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
In-Reply-To: <CAKfTPtC_tzc8xJkL1QUgn35dZ53g3-+V=qX7aefG89AGKJkQOw@mail.gmail.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-2-git-send-email-juri.lelli@arm.com>
 <CAKfTPtC_tzc8xJkL1QUgn35dZ53g3-+V=qX7aefG89AGKJkQOw@mail.gmail.com>
Message-ID: <20160830161158.GE9337@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/16 11:02, Vincent Guittot wrote:
> On 19 July 2016 at 14:40, Juri Lelli <juri.lelli@arm.com> wrote:
> > ARM systems may be configured to have cpus with different power/performance
> > characteristics within the same chip. In this case, additional information
> > has to be made available to the kernel (the scheduler in particular) for it
> > to be aware of such differences and take decisions accordingly.
> >
> > Therefore, this patch aims at standardizing cpu capacities device tree
> > bindings for ARM platforms. Bindings define cpu capacity-dmips-mhz
> > parameter, to allow operating systems to retrieve such information from
> > the device tree and initialize related kernel structures, paving the way
> > for common code in the kernel to deal with heterogeneity.
> >

[...]

> 
> FWIW, Acked-by Vincent Guittot <vincent.guittot@linaro.org>
> 

Thanks!

Best,

- Juri
