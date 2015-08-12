From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Aug 2015 00:28:16 -0700
Subject: [RFC/PATCH-v4.2-rc6 2/5] arm: boot: dts: am4372: add ARM timers
 and SCU nodes
In-Reply-To: <1439242911-715-3-git-send-email-balbi@ti.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-3-git-send-email-balbi@ti.com>
Message-ID: <20150812072816.GR4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150810 14:44]:
> AM437x devices sport SCU, TWD and Global timers,
> let's add them to DTS so they have a chance to
> probe and be used by Linux.

Is this one safe to apply already without the Kconfig change?

Or will it cause multi_v7_defconfig with the timers selected
to not boot properly?

Regards,

Tony
