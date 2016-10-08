From: horms@verge.net.au (Simon Horman)
Date: Sat, 8 Oct 2016 11:28:51 +0900
Subject: [PATCH v3 04/11] ARM: dts: r8a7743: initial SoC device tree
In-Reply-To: <cd1391d1-d2b5-6315-ee15-0253019d9836@cogentembedded.com>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
 <2883940.Oo8sg10L7m@wasted.cogentembedded.com>
 <20161007030932.GH13721@verge.net.au>
 <cd1391d1-d2b5-6315-ee15-0253019d9836@cogentembedded.com>
Message-ID: <20161008022851.GA14617@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 12:57:28PM +0300, Sergei Shtylyov wrote:
> On 10/7/2016 6:09 AM, Simon Horman wrote:
> 
> >>The  initial R8A7743 SoC device tree including CPU cores, GIC, timer, SYSC,
> >>CPG, and the required clock descriptions.
> >>
> >>Based on the original (and large) patch by Dmitry Shifrin
> >><dmitry.shifrin@cogentembedded.com>.
> >>
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> >I notice that this patch enables two CPUs. Have you tested SMP and:
> >- CPU hotplug
> >- Suspend to RAM
> 
>    No, not really. I'll remove CPU1. :-<

Thanks.
