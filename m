From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 1 Feb 2013 08:41:37 +0000
Subject: [PATCH 0/5] ARM: OMAP2+: System timer updates
In-Reply-To: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED0725A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jan 30, 2013 at 22:34:26, Hunter, Jon wrote:
> This series consists mainly of clean-ups for clockevents and
> clocksource timers on OMAP2+ devices. The most significant change
> in functionality comes from the 5th patch which is changing the
> selection of the clocksource timer for OMAP3 and AM335x devices
> when gptimers are used for clocksource. This change came about from
> Vaibhav Bedia's series for AM335x [1]. See patch for more details on
> the exact nature of the change.
> 
> Boot tested with and without  device-tree on OMAP2420 H4,
> OMAP3430 SDP, OMAP3430 Beagle Board, OMAP4430 SDP and
> AM335x EVM (AM335x only supports device-tree boot).
> 

Thanks for working on this. I have couple of minor comments but with this
series in place I can drop the patch for interchanging the timers for AM33xx
and the suspend-resume handlers for the clockevent also don't need the
sprintf() that I had :)

Reviewed-and-Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
