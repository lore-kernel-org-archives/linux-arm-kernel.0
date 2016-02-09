From: horms@verge.net.au (Simon Horman)
Date: Tue, 9 Feb 2016 19:54:42 +0100
Subject: [PATCH 0/2] ARM: shmobile: Remove legacy machine_desc.map_io()
 callbacks
In-Reply-To: <CAMuHMdVP8_9Nk8FQvHyVqfhK+Yhz2g0weE3nCxQeZ1wpeAEEUQ@mail.gmail.com>
References: <1453994246-12886-1-git-send-email-geert+renesas@glider.be>
 <20160202140738.GC4304@verge.net.au>
 <CAMuHMdVP8_9Nk8FQvHyVqfhK+Yhz2g0weE3nCxQeZ1wpeAEEUQ@mail.gmail.com>
Message-ID: <20160209185441.GA12049@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 04:03:29PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Feb 2, 2016 at 3:07 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Jan 28, 2016 at 04:17:24PM +0100, Geert Uytterhoeven wrote:
> >> This patch series removes the legacy machine_desc.map_io() callback for
> >> SoCs that no longer rely on it, but use ioremap() instead.
> >>
> >> The patch for emev2 depends on "ARM: shmobile: Consolidate SCU mapping
> >> code" ("FIXME" commit ID reference to be updated).
> >>
> >> Thanks!
> >
> > Thanks, I have queued these up.
> 
> Thanks, but unfortunately it's not in renesas-devel-20160205-v4.5-rc2?

Sorry about that, I'll try to actually queue it up this time.
