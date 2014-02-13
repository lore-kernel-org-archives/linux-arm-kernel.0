From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Feb 2014 14:52:27 -0800
Subject: [PATCH] arm: omap1: fix build when !CONFIG_OMAP_32K_TIMER
In-Reply-To: <1389636237-2998-1-git-send-email-balbi@ti.com>
References: <1389636237-2998-1-git-send-email-balbi@ti.com>
Message-ID: <20140213225226.GE28216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140113 10:06]:
> If CONFIG_OMAP_32K_TIMER isn't enabled, we will
> try to use enable_dyn_sleep which wasn't defined
> anywhere.
> 
> In order to fix the problem, we always define
> enable_dyn_sleep as 0 when !CONFIG_OMAP_32K_TIMER.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Thanks applying into omap-for-v3.14/fixes.

Tony
