From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 15 Dec 2009 09:08:02 -0700 (MST)
Subject: [PATCH 1/1] ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg
	access.
In-Reply-To: <1260883872-22299-1-git-send-email-abhijitpagare@ti.com>
References: <1260883872-22299-1-git-send-email-abhijitpagare@ti.com>
Message-ID: <alpine.DEB.2.00.0912150906550.12561@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhijit,

On Tue, 15 Dec 2009, Abhijit Pagare wrote:

> In OMAP2/3 some of the clock-domains which did not have control
> facility were being falsely written to and read using the CM_CLKSTCTRL
> register though it did not exist for them. One check is added to remove
> this flaw.
> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Thanks Abhijit, queueing for .33-rcX.


- Paul
