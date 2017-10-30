From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Oct 2017 09:19:50 -0700
Subject: [PATCH 0/2] ARM: OMAP3: fix boot regression for N9
In-Reply-To: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
References: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
Message-ID: <20171030161950.GA7339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [171030 02:13]:
> Hi,
> 
> N9 boot is apparently broken with mainline, caused by some recent
> changes to TI clock drivers. The reason for failing boot is effectively
> missing hwmod data piece for MMC3, so add this in place. The CM
> related fix is also needed to properly handle idlest functionality
> on OMAP3; currently this is mostly masked but will cause issues in
> some places.

Thanks applying both into omap-for-v4.14/fixes. If these don't make
it to v4.14, these can always be requested for stable releases as
needed as specified in Documentation/process/stable-kernel-rules.rst.

Regards,

Tony
