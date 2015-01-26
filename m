From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Jan 2015 12:55:39 -0800
Subject: [PATCH] ARM: dts: OMAP: Add hwlock-base-id property to
 hwspinlock nodes
In-Reply-To: <1421269385-51381-1-git-send-email-s-anna@ti.com>
References: <1421269385-51381-1-git-send-email-s-anna@ti.com>
Message-ID: <20150126205538.GH28663@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [150114 13:06]:
> Add the generic property "hwlock-base-id" to the hwspinlock DT nodes
> on all applicable OMAP SoCS (OMAP4, OMAP5, DRA7, AM33xx and AM43xx).
> This common property is required by the hwspinlock core to be able
> to translate client locks properly. All the current OMAP SoCs only
> have a single instance of the IP, and so will use a common value of 0.

As it seems the base-id binding is still under a discussion,
I'll untag this one. Suman, please resend once the related
spinlock changes are queued.

Thanks,

Tony
