From: horms@verge.net.au (Simon Horman)
Date: Fri, 14 Aug 2015 09:30:23 +0900
Subject: [PATCH v2 0/6] ARM: shmobile: Move gpio ranges from C code to DT
In-Reply-To: <CAMuHMdW0T6MW6s4Gg_rqvtt+MRPtp_MpuiKtamfFrx-Tcm6WmQ@mail.gmail.com>
References: <1438696519-13727-1-git-send-email-geert+renesas@glider.be>
 <20150805005540.GB20726@verge.net.au>
 <CACRpkdY7P86+SxMr5-HnhrN5fC-N1U135jiGAJGTV=xx47VW5g@mail.gmail.com>
 <CAMuHMdW0T6MW6s4Gg_rqvtt+MRPtp_MpuiKtamfFrx-Tcm6WmQ@mail.gmail.com>
Message-ID: <20150814003023.GC12589@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 02:45:55PM +0200, Geert Uytterhoeven wrote:
> Hi Linus,
> 
> On Thu, Aug 13, 2015 at 2:29 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Aug 5, 2015 at 2:55 AM, Simon Horman <horms@verge.net.au> wrote:
> >> Where possible I prefer not to apply non-DTS/DTSI patches on top of
> >> DTS/DTSI patches, I believe this is in keeping with how the ARM SoC
> >> maintainers like things handled.  With this in mind I have done the following:
> >>
> >> 1. Queued up the DTSI patches (patches 1 - 3) for v4.3 in my dt branch.
> >>    I intend for this to turn up in next soon.
> >> 2. Queued up for pinctrl patches (patches 4 - 6) for v4.4 in a pinctrl patch.
> >>    I intend for these to be present in the renesas devel branch but
> >>    not in next until after the release of v4.3-rc1. I would also be
> >>    happy to drop them and let Linus Walleij take these patches for v4.4,
> >>    assuming patches 1 - 3 are accepted for v4.3.
> >
> > OK.
> >
> > Will the world explode if I try to queue the pinctrl patches 4-6 in my
> > tree now for v4.3? Then I prefer to defer to v4.4. Else I can merge
> > it in parallel?
> 
> There won't be a mapping between gpio and pins in any branch having the
> pinctrl changes but not the dtsi changes.

It sounds to me that Linus should take his option 2; defer to v4.4.
In which case I should drop the changes from my tree (they are not in next
anyway). Please let me know if thats the way we will move this forwards.
