From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jul 2015 23:26:17 -0700
Subject: [PATCH] ARM: DRA7: Provide proper IO map table
In-Reply-To: <1434985934-29132-1-git-send-email-nm@ti.com>
References: <1434985934-29132-1-git-send-email-nm@ti.com>
Message-ID: <20150715062616.GY17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [150622 08:14]:
> DRA7 uses OMAP5 IO table at the moment. This is purely spurious since
> the OMAP5 and DRA7 register maps are different in many aspects.
> 
> AM57xx/DRA7 TRM Reference: http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf
> 
> NOTE: Most of the drivers are already doing ioremap, so, there should'nt
> be any functional improvement involved here, other than making the
> initial iotable more accurate.
> 
> Fixes: a3a9384a1157 ("ARM: DRA7: Reuse io tables and add a new .init_early")
> Signed-off-by: Nishanth Menon <nm@ti.com>

Is this needed for v4.2-rc or can this wait for v4.3 merge window?

Regards,

Tony
