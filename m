From: horms@verge.net.au (Simon Horman)
Date: Wed, 7 Feb 2018 10:44:02 +0100
Subject: [PATCH] arm64: renesas_defconfig: enable R8A77980 SoC
In-Reply-To: <CAMuHMdUq92E8dcyBjkM0A_eoFhp_F6zA1pb5WvR2n_CSdUVFmg@mail.gmail.com>
References: <20180206132039.23437-1-horms+renesas@verge.net.au>
 <CAMuHMdUq92E8dcyBjkM0A_eoFhp_F6zA1pb5WvR2n_CSdUVFmg@mail.gmail.com>
Message-ID: <20180207094401.gxflheamr7l3jdih@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 06, 2018 at 03:44:13PM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 6, 2018 at 2:20 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > Enable the Renesas R-Car V3H (R8A77980) SoC in the ARM64 renesas_defconfig.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>


I have applied this to the topic/renesas-defconfig branch which is included
in the devel branch and tags of the Renesas tree as a convenience to
developers.  The branch is not, however, included in the next branch or
tags nor is it targeted at upstream.
