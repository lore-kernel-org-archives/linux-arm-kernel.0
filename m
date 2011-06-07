From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 7 Jun 2011 22:06:07 +0300
Subject: [PATCH v2 5/5] spi/ep93xx: add DMA support
In-Reply-To: <BANLkTikKOcc2Vg1p3kG4ZSLjJ0RTZWS=2A@mail.gmail.com>
References: <cover.1306662317.git.mika.westerberg@iki.fi>
	<4b27fc93b7df900943e7c12084a8340cbc5fe1a8.1306662317.git.mika.westerberg@iki.fi>
	<20110603204400.GH17972@ponder.secretlab.ca>
	<20110607171403.GA3011@acer>
	<BANLkTikKOcc2Vg1p3kG4ZSLjJ0RTZWS=2A@mail.gmail.com>
Message-ID: <20110607190607.GB3011@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 12:45:26PM -0600, Grant Likely wrote:
> On Tue, Jun 7, 2011 at 11:14 AM, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> >
> > I just realized that once the SPI driver renaming patch (spi: reorganize
> > drivers) enters linux-next, this patch (which sits on Vinod's tree) will cause
> > a merge conflict. Any ideas how to avoid it beforehand?
> 
> Yes, put the whole series into a separate branch all by itself.  Merge
> that branch into Vinod's tree and I'll also merge it into spi/next,
> and I'll fix up the merge conflict when I do.

More stupid questions: Do you mean that I create a branch in my public
repository somewhere? If that is the case, then there is a problem that I
don't have any public repository and I doubt that I get such before linux-next
is rebuilt.
