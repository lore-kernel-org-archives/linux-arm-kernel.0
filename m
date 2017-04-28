From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 28 Apr 2017 11:02:26 +0200
Subject: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
In-Reply-To: <20170427133819.GW3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
 <20170424021747.GA630@jagdpanzerIV.localdomain>
 <20170427133819.GW3452@pathway.suse.cz>
Message-ID: <20170428090226.qqoe6qbewjeo57kd@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 03:38:19PM +0200, Petr Mladek wrote:
> Also we need to look for alternatives. There is a chance
> to create crashdump and get the ftrace messages from it.
> Also this might be scenario when we might need to suggest
> the early_printk() patchset from Peter Zijlstra.

I'd be happy to repost those. I still carry them in my tree.
