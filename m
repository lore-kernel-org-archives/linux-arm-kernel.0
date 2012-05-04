From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 4 May 2012 17:59:42 +0200
Subject: [PATCH 01/11] OMAP2+: Add SoC specific map_io functions
In-Reply-To: <1316809399-19579-2-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-2-git-send-email-b-cousson@ti.com>
Message-ID: <20120504175942.5ceb8e91@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Benoit,

Le Fri, 23 Sep 2011 22:23:09 +0200,
Benoit Cousson <b-cousson@ti.com> a ?crit :

> Add SoC specific map_io function to be used by the generic DT
> board file. This is an intermediate step before having some
> generic DT aware map_io function.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Do you know if some progress has been made on having a generic DT aware
map_io function, or is the per-SoC ->map_io() function still the
recommended way of handling SoC having different requirements of static
mappings at boot time?

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
