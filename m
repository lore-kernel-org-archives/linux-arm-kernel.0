From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 12 Feb 2014 18:24:05 +0100
Subject: [PATCH RFC v2 00/35] Second preview of imx-drm cleanup series
In-Reply-To: <20140212095606.GM26684@n2100.arm.linux.org.uk>
References: <20140210122802.GS26684@n2100.arm.linux.org.uk>
 <20140212095606.GM26684@n2100.arm.linux.org.uk>
Message-ID: <1392225845.5536.53.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 12.02.2014, 09:56 +0000 schrieb Russell King - ARM
Linux:
> On Mon, Feb 10, 2014 at 12:28:03PM +0000, Russell King - ARM Linux wrote:
> > This is the latest revision of my series cleaning up imx-drm and
> > hopefully getting it ready to be moved out of drivers/staging.
> > This series is updated to v3.14-rc2.
> > 
> > Since the last round of patches were posted, the component support
> > has been merged into mainline, and thus dropped from this series.
> > Greg has taken the first three patches and merged them into his
> > linux-next tree - however, I include them here for completness.
> > 
> > Most of the comments from last time still apply, and I'll look at
> > incorporating some of the other patches that were posted in the
> > coming week.
> > 
> > If I can have some acks for this, I'll start sending some of it to
> > Greg - I'd like to at least get the five or six initial imx-hdmi
> > patches to Greg and queued up for the next merge window sooner
> > rather than later, preferably getting most of this ready for that
> > window too.
> 
> So far, only the first few patches have been acked by one person.  What
> about the remainder?  There's been no comments on them either...

With the understanding that I loathe the current DT bindings, which are
not the fault of this series:

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
