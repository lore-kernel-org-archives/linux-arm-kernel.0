From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 19 Oct 2010 16:57:59 +0200
Subject: [PATCH v2] omap4: pandaboard: fix up mmc card detect logic
In-Reply-To: <1287499825-24988-1-git-send-email-nm@ti.com>
References: <1287499825-24988-1-git-send-email-nm@ti.com>
Message-ID: <20101019145758.GU2736@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On Tue, Oct 19, 2010 at 09:50:25AM -0500, Nishanth Menon wrote:
> From: Menon, Nishanth <nm@ti.com>
> 
> For MMC1 Controller, card detect interrupt source is
> twl6030 which is non-gpio. The card detect call back function provides
> card present/absent status by reading MMC Control register present
> on twl6030. This functionality was introduced in mfd tree on
> track to kernel.org
> 
> Sync pandaboard to the same and make mmc work.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> 
> Acked-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Tested-by: Jarkko Nikula <jhnikula@gmail.com>
> Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
Patch applied, thanks a lot.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
