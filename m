From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 15 Mar 2013 10:37:32 +0200
Subject: [PATCH 1/4] mtd: merge mtdchar module with mtdcore
In-Reply-To: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
References: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
Message-ID: <1363336652.11441.116.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-14 at 13:27 +0200, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> The MTD subsystem has historically tried to be as configurable as possible. The
> side-effect of this is that its configuration menu is rather large, and we are
> gradually shrinking it. For example, we recently merged partitions support with
> the mtdcore.
> 
> This patch does the next step - it merges the mtdchar module to mtdcore. And in
> this case this is not only about eliminating too fine-grained separation and
> simplifying the configuration menu. This is also about eliminating seemingly
> useless kernel module.

I've pushed the patch-set to the l2-mtd.git tree.

-- 
Best Regards,
Artem Bityutskiy
