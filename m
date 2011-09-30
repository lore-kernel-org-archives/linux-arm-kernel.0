From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 30 Sep 2011 12:58:03 -0600 (MDT)
Subject: [PATCH v2] ARM: OMAP2+: clock: cleanup CPUfreq leftovers
In-Reply-To: <1316793611-9949-1-git-send-email-khilman@ti.com>
References: <1316793611-9949-1-git-send-email-khilman@ti.com>
Message-ID: <alpine.DEB.2.00.1109301257100.12185@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Sep 2011, Kevin Hilman wrote:

> Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
> longer need/use the clock framework code for filling up CPUfreq
> tables.  Remove it.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Queued for 3.3 cleanups (to avoid potential dependency issues with which 
of our branches is merged first) - thanks Kevin.


- Paul
