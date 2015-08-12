From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Aug 2015 00:14:24 -0700
Subject: [RFC/PATCH-v4.2-rc6 4/5] arm: omap2: timer: simplify
 omap4_local_timer_init()
In-Reply-To: <1439242911-715-5-git-send-email-balbi@ti.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-5-git-send-email-balbi@ti.com>
Message-ID: <20150812071424.GO4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150810 14:44]:
> all users of omap4_local_timer_init() are already
> DT-only, so we can remove the check for having
> DTB or not.
> 
> While at that, fix a typo in comment.

We already have d1dabab2841d ("ARM: OMAP2+: Clean up
omap4_local_timer_init") in Linux next reviewed-by you :)

Tony
