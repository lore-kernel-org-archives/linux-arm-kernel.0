From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Nov 2014 16:02:44 -0800
Subject: [PATCH 0/2] ARM: OMAP4+: PM: centralize static dependency
 mapping table
In-Reply-To: <1413922949-22300-1-git-send-email-nm@ti.com>
References: <1413922949-22300-1-git-send-email-nm@ti.com>
Message-ID: <20141111000243.GI31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [141021 13:23]:
> Hi,
> 
> This is a small step towards getting rid of static dependency logic
> from mach-omap2. As part of this, we split the list of static dep
> map from the function implementing it. This should eventually aid in
> helping remove the tables from the kernel to the device tree at a
> later point in time of cleanup.
> 
> Series based on v3.18-rc1 and could be a 3.19-rc1 material.

Applying into omap-for-3.19/soc thanks.

Tony
