From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 03:16:29 -0700
Subject: [PATCH v2 5/5] ARM: OMAP1: nokia770: enable Tahvo
In-Reply-To: <1371389712-29516-6-git-send-email-aaro.koskinen@iki.fi>
References: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
 <1371389712-29516-6-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20130618101628.GK5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130616 06:41]:
> Add platform data for Tahvo.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks, applying into omap-for-v3.11/board. I left out
the .extcon entry to remove the dependency to the USB patches.

Then the rest of the series can be queued along with other
USB patches, and you can do a follow-up patch to patch in
.extcon.

Regards,

Tony 
