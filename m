From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Jul 2018 13:45:53 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add RWDT support
In-Reply-To: <CAMuHMdVeyaU9iKnubhzkjN8Fd-Z-=r+yoF+_jGoFxDzPdwbSpQ@mail.gmail.com>
 <4eb91e29-9c2f-6f7c-2b3c-983e41430e26@cogentembedded.com>
Message-ID: <20180724114552.aybrijeonsj2tmcw@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 07:14:28PM +0300, Sergei Shtylyov wrote:
> On 07/23/2018 07:08 PM, Simon Horman wrote:
> 
> >> Describe RWDT in the R8A77980 SoC device tree.
> >>
> >> Enable RWDT on the Condor and V3H Starter Kit boards.
> >>
> >> Based on the original (and large) patch by Vladimir Barinov.
> >>
> >> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >> ---
> >> The patch is against the 'renesas-devel-20180720-v4.18-rc5' of Simon Horman's
> >> 'renesas.git' repo.  It depends on Geert Uytterhoeven's clock driver patches
> >> (adding the RWDT clock) in order to work...
> > 
> > But it is safe to apply without those patches, right?
> 
>    The RWDT driver should just fail to probe with -ENOENT. 

...

On Tue, Jul 24, 2018 at 09:01:59AM +0200, Geert Uytterhoeven wrote:
> On Fri, Jul 20, 2018 at 9:21 PM Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Describe RWDT in the R8A77980 SoC device tree.
> >
> > Enable RWDT on the Condor and V3H Starter Kit boards.
> >
> > Based on the original (and large) patch by Vladimir Barinov.
> >
> > Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for v4.20.
