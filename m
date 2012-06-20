From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jun 2012 03:44:40 -0700
Subject: [RFC PATCH 3/3] arm: omap: phy: remove unused functions from
 omap-phy-internal.c
In-Reply-To: <1338388466-3565-4-git-send-email-kishon@ti.com>
References: <1338388466-3565-1-git-send-email-kishon@ti.com>
 <1338388466-3565-4-git-send-email-kishon@ti.com>
Message-ID: <20120620104440.GE12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [120530 07:38]:
> All the unnessary functions in omap-phy-internal is removed.
> These functionality are now handled by omap-usb2 phy driver.

Glad to see these move to live under drivers. Up to Felipe
to merge via linux-usb once the driver parts are finished:

Acked-by: Tony Lindgren <tony@atomide.com>
