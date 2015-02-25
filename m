From: horms@verge.net.au (Simon Horman)
Date: Wed, 25 Feb 2015 17:07:11 +0900
Subject: [PATCH 0/2] Add R8A7794 GPIO DT support
In-Reply-To: <54EC8E07.1030301@cogentembedded.com>
References: <6954455.LyoCrfjM8R@wasted.cogentembedded.com>
 <20150223220030.GA29878@verge.net.au>
 <20150223231901.GD29878@verge.net.au>
 <54EC8E07.1030301@cogentembedded.com>
Message-ID: <20150225080707.GB31211@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 05:43:19PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 02/24/2015 02:19 AM, Simon Horman wrote:
> 
> >>>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> >>>'renesas-devel-20150220-v3.19' tag. Here we add the GPIO device tree support
> >>>for the R8A7794 SoC. It depends on the R8A7794 PFC/MMCIF device tree patches
> >>>posted recently in order to apply.
> 
> >>>[1/2] ARM: shmobile: r8a7794: add GPIO clocks
> >>>[2/2] ARM: shmobile: r8a7794: add GPIO DT support
> 
> >>Thanks,  I have queued these up with Geert's Acks.
> 
> >Sorry, I was too hasty again. I have dropped these pending the
> >dependencies being queued up.
> 
>    Ah, I just didn't mention that the PFC patch is necessary for the latter
> patch to compile (but I don't expect it to change, so IMHO you can apply the
> PFC patch now). The former patch still can be merged, I think.

Thanks, I am coming around to your view that it is unlikely that the PFC
bindings will to change at this point.

It would help me greatly if you could put together all the silk/R8A7794
.dts and .dtsi patches that you think are ready to be merged into a single
series for me to look over (again).

Thanks in advance.
