From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 15:03:34 +0000
Subject: [PATCH v4 0/5] ARM: davinci: re-arrange definitions to have a
 common davinci header
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6043FD6@DBDE01.ent.ti.com>
References: <1323352528-1207-1-git-send-email-manjunath.hadli@ti.com>
 <DF0F476B391FA8409C78302C7BA518B6043FD6@DBDE01.ent.ti.com>
Message-ID: <20111212150334.GA20178@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 11:25:11AM +0000, Nori, Sekhar wrote:
> Hi Manju,
> 
> On Thu, Dec 08, 2011 at 19:25:23, Hadli, Manjunath wrote:
> > Re-arrange definitions and remove unnecessary code so that we can
> > have a common header for all davinci platforms. This will enable
> > us to share defines and enable common routines to be used without
> > polluting hardware.h.
> >  This patch set forms the base for a later set of patches for having
> > a common system module base address (DAVINCI_SYSTEM_MODULE_BASE).
> 
> Its easy to dismiss this series as causing "needless churn" by
> moving around definitions from header to C files and consolidating
> definitions from multiple header files to one.
> 
> You need to do a better job of "selling" this series. The best way
> to do that would be to include future patches which benefit from
> this series into this series itself. This way, its clear to judge
> the relative benefit of the "churn". You gave some examples, but
> showing code helps.
> 
> Also, one of the biggest gains from this series is reducing the
> pollution in include/mach as asked by Russell in his "pet peaves"
> mail. That should find reference in the cover letter and in the
> commit text of patch 5/5.

Indeed, and I hope it takes into account (at some point) the restart
changes.
