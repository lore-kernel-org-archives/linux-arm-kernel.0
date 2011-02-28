From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 28 Feb 2011 10:29:15 +0200
Subject: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to omap_display
In-Reply-To: <AANLkTikqPfjt=hemHWEu8OmAMmQDz4zNLzQqECKfPULM@mail.gmail.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	<1295850125-21405-6-git-send-email-sumit.semwal@ti.com>
	<1298539643.16119.54.camel@deskari> <1298876015.2096.36.camel@deskari>
	<4D6B4A1A.9000304@ti.com> <1298877549.2096.47.camel@deskari>
	<4D6B4E45.7080108@ti.com>
	<AANLkTikqPfjt=hemHWEu8OmAMmQDz4zNLzQqECKfPULM@mail.gmail.com>
Message-ID: <1298881755.2278.4.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 02:16 -0600, Semwal, Sumit wrote:
> Hi,
> 
> On Mon, Feb 28, 2011 at 12:57 PM, archit taneja <archit@ti.com> wrote:

<snip>

> > Yes, it might get misleading if someone looking at the code tries to find
> > "core" in the TRM, I guess we should stick to "omapdss_dss", this also
> > ensures a uniform matching of the platform driver names and the beginning of
> > register names for each HW module.
> 
> Hmmm... I guess omapdss_dss seems a better name in this view; I'm ok
> with this way of naming - do you want me to send a patch for it, or
> would you update this patch itself?

I've made the change. I changed the commits in my tree according to this
new naming. Quite a bit of changes, so I removed tested-bys from the
patches. I'll do some more testing, and push the changes to my master
branch.

 Tomi
