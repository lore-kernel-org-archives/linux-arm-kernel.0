From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Aug 2017 17:43:37 +0200
Subject: [PATCH v2 1/3] ARM: dts: r8a7790: Use R-Car SATA Gen2 fallback
 compat string
In-Reply-To: <CAMuHMdXYXU_ox_8d1jC+jgbwupzFWuxDtVSATWSyMxYVZz6kLA@mail.gmail.com>
References: <1502267203-12229-1-git-send-email-horms+renesas@verge.net.au>
 <1502267203-12229-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXYXU_ox_8d1jC+jgbwupzFWuxDtVSATWSyMxYVZz6kLA@mail.gmail.com>
Message-ID: <20170815154336.GA26748@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 03:57:59PM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 9, 2017 at 10:26 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Use newly added R-Car SATA Gen2 fallback compat string
> > in the DT of the r8a7790 SoC.
> >
> > This should have no run-time effect as the driver matches against
> > the per-SoC compat string before the fallback compat string is considered.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks. I have applied this and the other two patches in this series
with your Acks.
