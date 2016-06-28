From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Jun 2016 13:52:16 +0200
Subject: [PATCH v2 01/14] ARM: clk: sunxi: Add driver for the H3 THS clock
In-Reply-To: <6a37450f-35fe-3296-da4b-10f7d645e2b9@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-2-megous@megous.com>
 <20160625071338.GC4000@lukather>
 <6a37450f-35fe-3296-da4b-10f7d645e2b9@megous.com>
Message-ID: <20160628115216.GF5550@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 25, 2016 at 05:23:12PM +0200, Ond?ej Jirman wrote:
> Hi Maxime,
> 
> I try to base everything on the torvalds's kernel.
> 
> I did notice the patches. Is there some main git tree/branch where this
> work is tracked in? I'd gladly use it.

I just pushed it, branch sunxi/pen/clk-rework, on my github repo:
https://github.com/mripard/linux

> Also there's a PLL1 rate application patch, that would need to be ported
> to the new CCU code, in the case I would use it as a base for this work.
> Given that the new CCU code is your work and it's fresh in your mind, do
> you have suggestion how to approach it?
> 
> It is [PATCH v2 06/14] in this series.

Yes, it's still in my queue of things to review, let's discuss this on
this patch thread.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/46441f3b/attachment.sig>
