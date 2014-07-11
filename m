From: horms@verge.net.au (Simon Horman)
Date: Fri, 11 Jul 2014 17:09:22 +0200
Subject: [PATCH 10/13] [RFC] ARM: dts: Add shmobile platform device tree
 bindings documentation
In-Reply-To: <CAMuHMdXP6GfO7OEnXU8x4Sn5j8_tA2nnrFANr1sriB-B4BYoOQ@mail.gmail.com>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
 <1404908623-909-11-git-send-email-geert+renesas@glider.be>
 <20140711091720.GO12420@verge.net.au>
 <CAMuHMdXP6GfO7OEnXU8x4Sn5j8_tA2nnrFANr1sriB-B4BYoOQ@mail.gmail.com>
Message-ID: <20140711150921.GA1777@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 04:26:03PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Jul 11, 2014 at 11:17 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Jul 09, 2014 at 02:23:40PM +0200, Geert Uytterhoeven wrote:
> >> Add Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> >> Documentation, listing supported SoCs and boards.
> >>
> >> This allows to use checkpatch to validate DTSes referring to Renesas
> >> shmobile SoCs, and boards containing those SoCs.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: linux-arm-kernel at lists.infradead.org
> >
> > Thanks Geert,
> >
> > from my point of view this seems nice. Is there a reason it is marked as an RFC?
> 
> >From the cover letter:
> 
> "The last 4 patches contain compatible strings for new R-Car Gen2 SoCs,
>  which are not yet in active use, hence the RFC status."

Thanks, sorry for missing that.
