From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 30 Jan 2014 18:50:57 -0300
Subject: [PATCH v5 00/20] Armada 370/XP watchdog support
In-Reply-To: <20140130205315.GD29184@titan.lakedaemon.net>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140129181949.GB27143@localhost>
 <20140130205315.GD29184@titan.lakedaemon.net>
Message-ID: <20140130215056.GA1063@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 03:53:15PM -0500, Jason Cooper wrote:
> Ezequiel,
> 
> On Wed, Jan 29, 2014 at 03:19:50PM -0300, Ezequiel Garcia wrote:
> > On Mon, Jan 27, 2014 at 12:27:00PM -0300, Ezequiel Garcia wrote:
> > > A new round, mostly fixing some minor nitpicks.
> > > 
> > 
> > If anyone wants to give this a test, here's a public branch:
> > 
> > https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_for_v3.14_v5
> 
> I just took a quick glance at this (commit oneliners/tags) and there
> doesn't appear to be any dependence on Sebastian's series.  Did I miss
> something?
> 

True, I've completely missed that. I pushed the branch in a rush!

Let me prepare a v6, fixing the remaining issue pointed out by Russell,
and push again (together with Sebastian's irqchip fixes).

> Also, the MMIO patch hit mainline last night.
> 

Yup, I saw it. Thanks for the notice!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
