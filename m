From: horms@verge.net.au (Simon Horman)
Date: Tue, 7 Jun 2016 09:37:36 +0900
Subject: [PATCH v3 0/6] Add R8A7794/SILK sound DT support
In-Reply-To: <b77ad169-c9d1-4d67-0973-fc9639ddb613@cogentembedded.com>
References: <2378837.cigT3tNQPe@wasted.cogentembedded.com>
 <7d19e749-8264-9004-64f4-aefabda699c6@cogentembedded.com>
 <b77ad169-c9d1-4d67-0973-fc9639ddb613@cogentembedded.com>
Message-ID: <20160607003736.GB20591@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 09:11:17PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 05/13/2016 12:16 AM, Sergei Shtylyov wrote:
> 
> >>   Here's the set of 6 patches against Simon Horman's 'renesas.git' repo,
> >>'renesas-devel-20160509-v4.6-rc7' tag. I'm adding the sound device tree support
> >>for the R8A7794 SoC based SILK board.
> >>
> >>[1/6] ARM: dts: r8a7794: add audio clocks
> >>[2/6] ARM: dts: r8a7794: add MSTP5 clocks
> >>[3/6] ARM: dts: r8a7794: add MSTP10 clocks
> >>[4/6] ARM: dts: r8a7794: add Audio-DMAC support
> >>[5/6] ARM: dts: r8a7794: add sound support
> >>[6/6] ARM: dts: silk: add sound support
> >
> >   Oops, forgot to mention that patch #5 depends on the R-Car sound patch
> >posted yesterday in order to get interpreted as intended (it uses a disabled
> >SRC node).
> 
>   Simon, that patch has already hit Linus' tree but this series seems to be
> stuck. Please merge!

Hi Sergei,

there seem to be some outstanding review comments for v3 of this patchset.
Could you address them and repost?

Thanks!
