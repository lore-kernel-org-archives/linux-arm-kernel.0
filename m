From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jun 2012 11:31:45 -0600 (MDT)
Subject: [PATCH 2/2] Revert "ARM: OMAP2+: clockdomains: make {prm,
 cm}_clkdm common"
In-Reply-To: <1339433225-30042-3-git-send-email-b-cousson@ti.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com>
 <1339433225-30042-3-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1206111126521.5849@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2012, Benoit Cousson wrote:

> Neither prm_clkdm nor cm_clkdm does exist on OMAP4.
> Remove the common definition that does not make sense anymore
> since it is not common for OMAP2+ platforms.
> 
> Please note that these clock domains are probably non existant
> on OMAP 2 & 3 and thus should be removed in all the
> clockdomain files.

For the archives:

http://marc.info/?l=linux-omap&m=133943578712129&w=2


- Paul
