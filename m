From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 10:26:50 +0100
Subject: [PATCH 2/3] soc: renesas: Identify R-Car M3-W ES1.1
In-Reply-To: <20171101084237.atr25lujcqctwhjj@verge.net.au>
References: <1509384599-28953-1-git-send-email-geert+renesas@glider.be>
 <1509384599-28953-3-git-send-email-geert+renesas@glider.be>
 <20171101084237.atr25lujcqctwhjj@verge.net.au>
Message-ID: <20171110092649.6m4ltkoq7z53apvx@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 09:42:38AM +0100, Simon Horman wrote:
> On Mon, Oct 30, 2017 at 06:29:58PM +0100, Geert Uytterhoeven wrote:
> > The Product Register of R-Car M3-W ES1.1 incorrectly identifies the SoC
> > revision as ES2.0.  Add a workaround to fix this.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Is it already known how future revisions will be identified?
> 
> I'd like there to be some sort of conclusion to that discussion before
> applying that patch (I seem to recall we discussed it some time ago
> but I don't recall the outcome). The reason that I am being cautious here
> is that it potentially has implications for old-kernel/new-SoC compatibility
> which may be hard to fix later.
> 
> I am happy to apply the other patches in the series if you think that is
> worthwhile.

After some discussion off-list I am now satisfied that the approach you
have taken - to special case as identifying ES1.1 as what would otherwise
be identified ES2.0 - is not likely to cause problems with future SoC
releases.

I have applied this patch for v4.16.
