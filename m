From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 30 Jan 2014 19:37:39 -0300
Subject: [PATCH v5 00/20] Armada 370/XP watchdog support
In-Reply-To: <52EACB92.2080700@gmail.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140129181949.GB27143@localhost>
 <20140130205315.GD29184@titan.lakedaemon.net>
 <20140130215056.GA1063@localhost> <52EACB92.2080700@gmail.com>
Message-ID: <20140130223738.GA1261@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 11:00:50PM +0100, Sebastian Hesselbarth wrote:
> On 01/30/2014 10:50 PM, Ezequiel Garcia wrote:
> > On Thu, Jan 30, 2014 at 03:53:15PM -0500, Jason Cooper wrote:
> >> Ezequiel,
> >>
> >> On Wed, Jan 29, 2014 at 03:19:50PM -0300, Ezequiel Garcia wrote:
> >>> On Mon, Jan 27, 2014 at 12:27:00PM -0300, Ezequiel Garcia wrote:
> >>>> A new round, mostly fixing some minor nitpicks.
> >>>>
> >>>
> >>> If anyone wants to give this a test, here's a public branch:
> >>>
> >>> https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_for_v3.14_v5
> >>
> >> I just took a quick glance at this (commit oneliners/tags) and there
> >> doesn't appear to be any dependence on Sebastian's series.  Did I miss
> >> something?
> >>
> >
> > True, I've completely missed that. I pushed the branch in a rush!
> >
> > Let me prepare a v6, fixing the remaining issue pointed out by Russell,
> > and push again (together with Sebastian's irqchip fixes).
> 
> Umm, no. Just directly name irqchip-orion fixes. Jason will send a PR
> for irqchip-fixes _with-in_ v3.14 while watchdog will go into v3.15.
> 

That sounds good.

> Or are there any plans to get watchdog in *now*?
> 

Not on my side, I'm aiming at v3.15.

> In any way, do not include my patches into your set.
> 

Hm, maybe I've misexpressed myself. I wasn't intending to include
the patches on a submission, but just in a branch on the github repo.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
