From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jul 2015 04:15:57 -0700
Subject: [PATCH - resend for 4.2-rc2] ARM: DTS: dra7x: Integrate sDMA
 crossbar
In-Reply-To: <1435755149-10328-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435755149-10328-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150714111557.GT17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150701 05:54]:
> The sDMA requests are routed through the DMA crossbar and without the
> crossbar only peripherals using DMA request 0-127 can be used.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Tony,
> 
> as you have suggested: http://permalink.gmane.org/gmane.linux.ports.arm.omap/125999
> the DTS change has not been taken by Vinod.
> Now that the dmaengine pull request is in for 4.2 it would be great if you could
> pick up the DTS part of the series and send it for -rc2.

Thanks, looks like I also had the original patch still tagged.
Applying this one instead although they look the same.

Tony
