From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Sep 2018 16:19:07 -0500
Subject: [PATCH] perf: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828170258.GD19825@arm.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-38-robh@kernel.org>
 <20180828170258.GD19825@arm.com>
Message-ID: <CAL_Jsq+L+vvfh_Co6FXkyhBbwct16t8sWsw3J7hmXP4uaJaaPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 12:02 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Aug 27, 2018 at 08:52:39PM -0500, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/perf/arm_pmu_platform.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Cheers, I can queue this up for 4.20. Let me know if you'd rather take it
> along with the name pointer removal instead.

I assumed you were going to take this since I didn't say otherwise,
but looks like it is not in linux-next. Please take thru your tree.

Rob
