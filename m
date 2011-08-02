From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 2 Aug 2011 14:40:30 +0100
Subject: [PATCH v3 1/2] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <20110802060936.GA9972@freescale.com>
References: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
	<1312226252-8566-2-git-send-email-shawn.guo@linaro.org>
	<CACxGe6vvL=xGCGMR0yhyJ8r2zLvBgYhYS1b9_VF3dg5hRNhNzQ@mail.gmail.com>
	<20110802060936.GA9972@freescale.com>
Message-ID: <20110802134030.GA20071@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 02:09:37PM +0800, Shawn Guo wrote:
> On Mon, Aug 01, 2011 at 11:01:39PM +0100, Grant Likely wrote:
> > On Mon, Aug 1, 2011 at 8:17 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > However, today when we were talking you asked if it would be better to
> > use a callback into board-specific code instead of the iomux table
> > that is implemented in this patch.  I was fine either way, but my
> > opinion was that the table would probably result in less code.  Well,
> > combined with the above problem, I think I was wrong.  Since the only
> > difference in the ard variant is the call to
> > imx53_ard_weim_cs_config(), both the cs config and the iomux setup
> > will be simpler if both are handled in a callback.  You're original
> > instinct was correct.
> > 
> 
> Ok, here you go.

Yes, I think this is the right approach.  Go ahead and spin it into a
real patch series and repost.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
