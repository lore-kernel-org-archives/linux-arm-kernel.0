From: s-anna@ti.com (Suman Anna)
Date: Thu, 22 Oct 2015 12:11:51 -0500
Subject: [PATCH 1/2] ARM: OMAP2+: Remove legacy mailbox device
 instantiation
In-Reply-To: <1442273833-25013-2-git-send-email-s-anna@ti.com>
References: <1442273833-25013-1-git-send-email-s-anna@ti.com>
 <1442273833-25013-2-git-send-email-s-anna@ti.com>
Message-ID: <562918D7.6020202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 09/14/2015 06:37 PM, Suman Anna wrote:
> The legacy-style mailbox device creation is supported currently
> only for OMAP3, as all other SoCs are DT-boot only. Even on this
> SoC, there are no client drivers that utilize these mailbox devices.
> So, clean up the legacy-style mailbox device instantiation logic.
> The mailbox devices are already present and supported for the DT
> boot on OMAP3.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 

Ping, can you pick up this patch for your cleanup branch? FYI, Paul is
queueing Patch 2.

regards
Suman
