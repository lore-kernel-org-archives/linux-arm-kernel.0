From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 7 Jul 2011 16:09:08 -0600 (MDT)
Subject: [PATCH v2] OMAP: omap_device: Create clkdev entry for hwmod
	main_clk
In-Reply-To: <1309555101-21198-1-git-send-email-b-cousson@ti.com>
References: <1309555101-21198-1-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1107071607580.2647@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Extend the existing function to create clkdev for every optional
> clocks to add a well one "fck" alias for the main_clk of the
> omap_hwmod.
> It will allow to remove these static clkdev entries from the
> clockXXX_data.c file.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Todd Poynor <toddpoynor@google.com>

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'omap_device_a_3.1' branch.


- Paul
