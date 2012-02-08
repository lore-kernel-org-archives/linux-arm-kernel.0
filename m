From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 8 Feb 2012 11:16:36 -0700 (MST)
Subject: [PATCH] ARM: OMAP2+: clock: cleanup CPUfreq leftovers
In-Reply-To: <1327960788-28905-1-git-send-email-khilman@ti.com>
References: <1327960788-28905-1-git-send-email-khilman@ti.com>
Message-ID: <alpine.DEB.2.00.1202081115390.26892@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Jan 2012, Kevin Hilman wrote:

> Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
> longer need/use the clock framework code for filling up CPUfreq
> tables.  Remove it.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Paul, now that the CPUfreq driver is in mainline (v3.3), this can be safely
> removed.

Thanks, queued for 3.4.


- Paul
