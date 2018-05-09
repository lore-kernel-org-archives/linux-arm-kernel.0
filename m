From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 May 2018 21:23:52 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add resets property
 CAN-FD node
In-Reply-To: <2889c7ff-1748-e435-c03c-cb36cf930b1d@cogentembedded.com>
References: <20180509175409.10507-1-horms+renesas@verge.net.au>
 <CAMuHMdXWHXtO1-0FucCsPTE22U_k+vdqCrDHgBFrM4+yEgXYcQ@mail.gmail.com>
 <20180509191435.vm2zfuuixbyd3drm@verge.net.au>
 <2889c7ff-1748-e435-c03c-cb36cf930b1d@cogentembedded.com>
Message-ID: <20180509192351.ubealepswr4i6pik@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 10:18:47PM +0300, Sergei Shtylyov wrote:
> On 5/9/2018 10:14 PM, Simon Horman wrote:
> 
> > > > Add resets property to CAN-FD node to describe it in the reset topology of
> > > > on-SoC devices.  This allows to reset the CAN-FD device using the Reset
> > > > Controller API.
> > > > 
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > 
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > Thanks, applied.
> 
>    You're too quick (and I'm on holiday today). Need "to| before "CAN-FD" in
> the subject. ;-)

Thanks, fixed.
