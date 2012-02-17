From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 17 Feb 2012 16:40:42 -0700 (MST)
Subject: [PATCH v3] ARM: OMAP: clock: cleanup CPUfreq leftovers
In-Reply-To: <1329342415-28702-1-git-send-email-khilman@ti.com>
References: <1329342415-28702-1-git-send-email-khilman@ti.com>
Message-ID: <alpine.DEB.2.00.1202171640120.859@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Feb 2012, Kevin Hilman wrote:

> Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
> longer need/use the clock framework code for filling up CPUfreq
> tables.  Remove it.
> 
> Thanks to Russell King for pointing out the parts I missed under
> plat-omap in the original version.
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Paul, this is an updated version of the previous one after a different
> CPUfreq patch from Russell made me realize I missed the plat-omap pieces.

Thanks, queued for 3.4.


- Paul
