From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 May 2018 21:14:36 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add resets property
 CAN-FD node
In-Reply-To: <CAMuHMdXWHXtO1-0FucCsPTE22U_k+vdqCrDHgBFrM4+yEgXYcQ@mail.gmail.com>
References: <20180509175409.10507-1-horms+renesas@verge.net.au>
 <CAMuHMdXWHXtO1-0FucCsPTE22U_k+vdqCrDHgBFrM4+yEgXYcQ@mail.gmail.com>
Message-ID: <20180509191435.vm2zfuuixbyd3drm@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 08:29:19PM +0200, Geert Uytterhoeven wrote:
> On Wed, May 9, 2018 at 7:54 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > Add resets property to CAN-FD node to describe it in the reset topology of
> > on-SoC devices.  This allows to reset the CAN-FD device using the Reset
> > Controller API.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
