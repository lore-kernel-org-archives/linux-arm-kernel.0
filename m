From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Sep 2012 22:05:11 -0700
Subject: [GIT PULL v2] ARM: AM33xx: hwmod/clock: add hwmod data and
 some clock/hwmod fixes for 3.7
In-Reply-To: <alpine.DEB.2.00.1209122344250.7275@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209121558540.17903@utopia.booyaka.com>
 <alpine.DEB.2.00.1209122344250.7275@utopia.booyaka.com>
Message-ID: <20120913050510.GC4521@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120912 16:46]:
> Hi Tony
> 
> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
> 
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a2-for-3.7
> 
> for you to fetch changes up to 83c115426818378370b8cf2be16ca19bdcdc2ac4:
> 
>   ARM: AM33XX: clock: Add dcan clock aliases for device-tree (2012-09-12 16:28:35 -0600)
> 
> ----------------------------------------------------------------
> AM33xx hwmod data and miscellaneous clock and hwmod fixes.  AM33xx
> should now boot on mainline after this is applied, according to
> Vaibhav.
> 
> This second version includes trailing commas at the end of structure
> records at Tony's request.  It also adds a OMAP_INTC_START macro
> expansion to each IRQ number to make the sparseirq conversion easier.

Thanks for updating it, pulling into devel-am33xx branch.

Regards,

Tony
