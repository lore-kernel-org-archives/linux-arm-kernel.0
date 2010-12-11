From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sat, 11 Dec 2010 09:25:34 -0600
Subject: [PATCH v3 5/5] OMAP: mailbox: add omap_device latency information
In-Reply-To: <1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
References: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>
	<1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
Message-ID: <AANLkTi=cQVr-T1mJeq9uaRn5VyXxBG-xcp79z898E6nx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 7:51 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> So that we can enable the main clock.

This should be:

Subject: OMAP: mailbox: use runtime pm for clk and sysc handling

Use runtime pm APIs to enable/disable mailbox clocks and to configure
SYSCONFIG registers.

And if someone agrees, device_latency can be merged with the previous
patch for device_build. I'll wait for comments and resubmit.

Regards,

Omar
