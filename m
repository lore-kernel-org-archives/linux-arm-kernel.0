From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Jul 2016 10:39:39 +0900
Subject: [PATCH v2 0/2] Add R8A7792 SDHI support
In-Reply-To: <4468057.gGDuR4B4DF@wasted.cogentembedded.com>
References: <4468057.gGDuR4B4DF@wasted.cogentembedded.com>
Message-ID: <20160725013939.GF12825@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 23, 2016 at 09:09:24PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20160722-v4.7-rc7' tag. We're adding the R8A7792 SDHI clocks and
> device nodes. They have been tested on the Blanche board -- I'm not posting the
> Blanche patch only because it has some strange interaction with the Ethernet
> chip, so that NFS root wouldn't work anymore...
> 
> [1/2] ARM: dts: r8a7792: add SD clocks
> [2/2] ARM: dts: r8a7792: add SDHI support

Thanks, I have queued this up for v4.9.
