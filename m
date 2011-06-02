From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 2 Jun 2011 16:51:30 -0600 (MDT)
Subject: [PATCH] OMAP: PM: omap_device: fix device power domain callbacks
In-Reply-To: <1306886694-11092-1-git-send-email-khilman@ti.com>
References: <1306886694-11092-1-git-send-email-khilman@ti.com>
Message-ID: <alpine.DEB.2.00.1106021649231.26852@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 May 2011, Kevin Hilman wrote:

> After commit 4d27e9dcff00a6425d779b065ec8892e4f391661 (PM: Make power
> domain callbacks take precedence over subsystem ones), the power
> domain callbacks need to call the driver callbacks instead of relying
> on the default subsystem (in this case, platform_bus) to handle the
> driver callbacks.
> 
> Validated on 3430/n900, 3530/Overo.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Will be queued in my for_3.0/pm-fixes branch unless there are objections.

Seems reasonable to me, although I'm not the expert here.


- Paul
