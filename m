From: horms@verge.net.au (Simon Horman)
Date: Tue, 31 Mar 2015 09:16:39 +0900
Subject: [PATCH/RFC 1/5] clk: shmobile: rcar-gen2: Add CPG Clock Domain
 support
In-Reply-To: <CAMuHMdUKjYH9U_o2q9maxCUfvijP=EpX=NUVGOnp=qOF7BHUOw@mail.gmail.com>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
 <1426708017-28885-2-git-send-email-geert+renesas@glider.be>
 <20150324230036.7930.50037@quantum>
 <20150325010440.GC1767@verge.net.au>
 <CAMuHMdUKjYH9U_o2q9maxCUfvijP=EpX=NUVGOnp=qOF7BHUOw@mail.gmail.com>
Message-ID: <20150331001636.GA16289@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 11:58:10AM +0200, Geert Uytterhoeven wrote:
> On Wed, Mar 25, 2015 at 2:04 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Mar 24, 2015 at 04:00:36PM -0700, Michael Turquette wrote:
> >> Quoting Geert Uytterhoeven (2015-03-18 12:46:53)
> >> > Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
> >> > driver using the generic PM Domain.  This allows to power-manage the
> >> > module clocks of SoC devices that are part of the CPG Clock Domain using
> >> > Runtime PM, or for system suspend/resume.
> >> >
> >> > SoC devices that are part of the CPG Clock Domain and can be
> >> > power-managed through their primary clock should be tagged in DT with a
> >> > proper "power-domains" property.
> >> >
> >> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> Looks good to me. Which tree do you want this patch to go through?
> >
> > My tree seems reasonable from my point of view.
> > Though at this point it would be targeted at v4.2.
> 
> Definitely. Please give Laurent some time to comment.

Sure, please post as a non-RFC once you think it is ready.
