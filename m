From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Jul 2016 13:25:21 +0900
Subject: [PATCH 0/2] R8A7792 clock fixes
In-Reply-To: <e3184a66-509b-209e-966d-3189f821c6f7@cogentembedded.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
 <e3184a66-509b-209e-966d-3189f821c6f7@cogentembedded.com>
Message-ID: <20160715042521.GE28151@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 11:30:25PM +0300, Sergei Shtylyov wrote:
> On 07/12/2016 12:50 AM, Sergei Shtylyov wrote:
> 
> >   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> >'renesas-devel-20160711-v4.7-rc7' tag. I've found a couple of issues in the
> >R8A7792 DT clock descriptions, so these patches are targeted as fixes for 4.8.
> 
>    Oops, those were atop of the PFC/GPIO/EtherAVB patches in my series.
> After moving them before those, there was offset -185 lines while applying
> -- tell me if I need to repost.
> 
> >[1/2] ARM: dts: r8a7792: add PLL1 divided by 2 clock
> >[2/2] ARM: dts: r8a7792: remove ADSP clock
> 
> WBR, Sergei

No need. I have queued these up.
