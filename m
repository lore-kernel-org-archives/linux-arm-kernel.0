From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 10 Apr 2012 12:13:32 -0600 (MDT)
Subject: [PATCHv6 19/19] ARM: OMAP4: hwmod data: I2C: add flag for context
 restore
In-Reply-To: <1334055397-899-20-git-send-email-shubhrajyoti@ti.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
 <1334055397-899-20-git-send-email-shubhrajyoti@ti.com>
Message-ID: <alpine.DEB.2.00.1204101212530.20894@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Apr 2012, Shubhrajyoti D wrote:

> Restore of context is not done for OMAP4. This patch
> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
> hwmod data which activates the restore for OMAP4.
> Currently the OMAP4 does not hit device off still the
> driver may have support for it.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Wamsley <paul@pwsan.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Thanks, queued for 3.5.  You can drop this from your series; it will 
likely cause merge conflicts if you don't.

- Paul
