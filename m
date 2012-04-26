From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 26 Apr 2012 13:25:48 -0600 (MDT)
Subject: [PATCH-V5 1/3] ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC
 timer to prcm-common header
In-Reply-To: <1335362340-14960-2-git-send-email-hvaibhav@ti.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
 <1335362340-14960-2-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1204261325380.10308@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Apr 2012, Vaibhav Hiremath wrote:

> Add missing idle_st bit for 32k-sync timer into the prcm-common
> header file, required for hwmod data.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> NOTE: This patch is same as first version, without any code changes.

Thanks, queued for 3.5.


- Paul
