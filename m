From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Oct 2014 10:43:00 +0000
Subject: where/how arm start first jump from svc to user in kernel
In-Reply-To: <CAOVJa8GWvDu1mOe3s-UBwMf9EhjmCdrJfExTHu84jNrFFtonGA@mail.gmail.com>
References: <CAOVJa8Ho8Qz847HipcESsu=tDmd77r=hj4TP3Ut-4DG5nyQosw@mail.gmail.com>
 <20141015162005.GF22949@e104818-lin.cambridge.arm.com>
 <CAOVJa8Fa25W=oNHridmq+zZCRWRgKZtH+Ykt=w_YSwcaqpaNhA@mail.gmail.com>
 <20141021124132.GE15293@leverpostej>
 <CAOVJa8Eg37q8Mkrs1epraRnwUwSV0MO0p74727gCsdaaDwgoWg@mail.gmail.com>
 <20141021161555.GG15293@leverpostej>
 <CAOVJa8HbSR82RBHVh8Dj=3=R81b+0wtsdfj4d7QvaRgxbOjeww@mail.gmail.com>
 <20141027142500.GB2629@leverpostej>
 <CAOVJa8GWvDu1mOe3s-UBwMf9EhjmCdrJfExTHu84jNrFFtonGA@mail.gmail.com>
Message-ID: <20141029104259.GA23500@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 05:41:58PM +0000, vichy wrote:
> hi Mark:
> >
> >> BTW, Could we get the conclusion that ARMv7 = ARMv8 +aarch32?
> >
> > AArch32 in ARMv8 is largely the same as ARMv7, but there are some
> > differences.
> Would you mind to let me know where we can find the difference in spec
> or some place else?

You will need to read the ARMv8 architecture reference manual and
compare that to the ARMv7 architecture reference manual for the details
you are interested in.

You can find both on ARM infocenter [1] after registration.

Thanks,
Mark.

[1] http://infocenter.arm.com
