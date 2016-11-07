From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2016 16:23:06 -0700
Subject: [PATCH] ARM: OMAP2+: PRM: initialize en_uart4_mask and
 grpsel_uart4_mask
In-Reply-To: <20161024110021.10259-1-colin.king@canonical.com>
References: <20161024110021.10259-1-colin.king@canonical.com>
Message-ID: <20161107232306.GF2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Colin King <colin.king@canonical.com> [161024 04:01]:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where has_uart4 is false, en_uart4_mask and grpsel_uart4_mask
> are not initialized and so any garbage value is being logically or'd into
> the write of PM_WKEN and OMAP3430_PM_MPUGRPSEL.  Fix this by initializing
> these masks to zero.

Thanks applying into omap-for-v4.9/fixes.

Regards,

Tony
