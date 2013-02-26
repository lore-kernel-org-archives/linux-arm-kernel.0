From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 26 Feb 2013 14:36:24 +0900
Subject: [PATCH 1/4] ARM: shmobile: sh73a0: fix Z and ZG clock hierarchy
In-Reply-To: <20130226042946.GB26820@verge.net.au>
References: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
 <1361553474-27022-2-git-send-email-g.liakhovetski@gmx.de>
 <20130226042946.GB26820@verge.net.au>
Message-ID: <CANqRtoRjs=OxsoUQrcL6nJG-o1RpxefO3BrjBj_A2GV8HNW=qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 1:29 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Feb 22, 2013 at 06:17:51PM +0100, Guennadi Liakhovetski wrote:
>> Z and ZG clocks on sh73a0 have pll0 as their parent, not pll1.
>
> Thanks I have applied this to the soc5 branch and thus queued it up for v3.10.
> Please let me know if you would prefer me to push it as a fix for v3.9.
> And in that vein, if you regard it as -stable material.

Thanks.

Perhaps other people disagree, but I recommend not being so trigger
happy with -stable unless it will potentially give us some upside.
AFAIK there is no in-tree consumer of this clock anyway, so involving
-stable without further testing seems like a lot of hassle with no
real benefit.

Cheers,

/ magnus
