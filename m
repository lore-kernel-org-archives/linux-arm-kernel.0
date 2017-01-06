From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Jan 2017 08:38:39 -0800
Subject: [PATCH v3] soc: ti: wkup_m3_ipc: Drop wait from
 wkup_m3_rproc_boot_thread
In-Reply-To: <1483653615-24378-1-git-send-email-spjoshi@codeaurora.org>
References: <1483653615-24378-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <20170106163839.GF2630@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sarangdhar Joshi <spjoshi@codeaurora.org> [170105 14:01]:
> The function wkup_m3_rproc_boot_thread waits for asynchronous
> firmware loading to parse the resource table before calling
> rproc_boot(). However, as the resource table parsing has been
> moved to rproc_boot(), there's no need to wait for the
> asynchronous firmware loading completion.  So, drop this.

Applying into omap-for-v4.11/drivers thanks.

Tony
