From: tj@kernel.org (Tejun Heo)
Date: Mon, 30 Mar 2015 13:35:15 -0400
Subject: [PATCH] sata_mv: Manage SATA port multiplier while searching for
 active links
In-Reply-To: <1427736765-846-1-git-send-email-gregory.clement@free-electrons.com>
References: <1427736765-846-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150330173515.GC9974@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Mar 30, 2015 at 07:32:45PM +0200, Gregory CLEMENT wrote:
> From: Nadav Haklai <nadavh@marvell.com>
> 
> With this patch, when searching for active link, first search through
> the port multiplier links. And then fall to the default ap active_tag
> only if no there is no active link in the port multiplier.

What does this fix?  What was broken before?  What's the impact of the
patch?  A patch description which just restates the patch content
isn't all that useful.

Thanks.

-- 
tejun
