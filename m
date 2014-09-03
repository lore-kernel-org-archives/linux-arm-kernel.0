From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Sep 2014 14:45:59 -0700
Subject: [PATCH] ARM: dts: am335x-bone*: Fix model name and update
 compatibility information
In-Reply-To: <1409760190-17275-1-git-send-email-nm@ti.com>
References: <1409760190-17275-1-git-send-email-nm@ti.com>
Message-ID: <20140903214558.GN11766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140903 09:03]:
> Beaglebone white and beaglebone black differ in tiny little aspects.
> This is the reason why we maintain seperate dts for these platforms.
> However, there is no real way to decode from dtb which platform it is
> since compatible and model name are the same for both platforms.
> 
> Fix this so that beaglebone black and beaglebone are identifiable,
> while maintaining compatibility for older zImages which might use old
> beaglebone compatible flag for black as well.
> 
> Reported-by: Tom Rini <trini@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks applying into omap-for-v3.18/fixes-not-urgent.

Regards,

Tony
