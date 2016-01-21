From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Jan 2016 13:57:45 -0800
Subject: [PATCH 1/2] ARM: OMAP2+: Remove legacy mailbox device
 instantiation
In-Reply-To: <56943936.4020003@ti.com>
References: <1442273833-25013-1-git-send-email-s-anna@ti.com>
 <1442273833-25013-2-git-send-email-s-anna@ti.com>
 <562918D7.6020202@ti.com> <56943936.4020003@ti.com>
Message-ID: <20160121215744.GQ19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [160111 15:23]:
> Hi Tony,
> 
> On 10/22/2015 12:11 PM, Suman Anna wrote:
> > Hi Tony,
> > 
> > On 09/14/2015 06:37 PM, Suman Anna wrote:
> >> The legacy-style mailbox device creation is supported currently
> >> only for OMAP3, as all other SoCs are DT-boot only. Even on this
> >> SoC, there are no client drivers that utilize these mailbox devices.
> >> So, clean up the legacy-style mailbox device instantiation logic.
> >> The mailbox devices are already present and supported for the DT
> >> boot on OMAP3.
> >>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/devices.c | 28 ----------------------------
> >>  1 file changed, 28 deletions(-)
> >>
> > 
> > Ping, can you pick up this patch for your cleanup branch? FYI, Paul is
> > queueing Patch 2.
> 
> Just checking your staged branches and linux-next, looks like this was
> missed. Let me know if you want me to repost this patch.

OK thanks applying into omap-for-v4.5/fixes.

Tony
