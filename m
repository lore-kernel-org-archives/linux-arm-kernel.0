From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Feb 2015 08:19:03 +0900
Subject: [PATCH 0/2] Add R8A7794 GPIO DT support
In-Reply-To: <20150223220030.GA29878@verge.net.au>
References: <6954455.LyoCrfjM8R@wasted.cogentembedded.com>
 <20150223220030.GA29878@verge.net.au>
Message-ID: <20150223231901.GD29878@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 07:00:33AM +0900, Simon Horman wrote:
> On Sun, Feb 22, 2015 at 01:10:19AM +0300, Sergei Shtylyov wrote:
> > Hello.
> > 
> >    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> > 'renesas-devel-20150220-v3.19' tag. Here we add the GPIO device tree support
> > for the R8A7794 SoC. It depends on the R8A7794 PFC/MMCIF device tree patches
> > posted recently in order to apply.
> > 
> > [1/2] ARM: shmobile: r8a7794: add GPIO clocks
> > [2/2] ARM: shmobile: r8a7794: add GPIO DT support
> 
> Thanks,  I have queued these up with Geert's Acks.

Sorry, I was too hasty again. I have dropped these pending the
dependencies being queued up.
