From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jul 2014 03:41:58 -0700
Subject: [PATCH 3/3] ARM: OMAP2+: create dsp device only on OMAP3 SoCs
In-Reply-To: <1403587467-59876-4-git-send-email-s-anna@ti.com>
References: <1403587467-59876-1-git-send-email-s-anna@ti.com>
 <1403587467-59876-4-git-send-email-s-anna@ti.com>
Message-ID: <20140707104157.GL28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [140623 22:26]:
> The DSP platform device for TI DSP/Bridge is currently
> created unconditionally whenever CONFIG_TIDSPBRIDGE is
> enabled. This device should only be created on OMAP34xx/
> OMAP36xx SoCs, and not for other OMAP3 derived SoCs or when
> booting multi-arch images on other SoCs. So, add a check for
> the SoC family both before creating the device and allocating
> the carveout memory for the device.

Applying this one into omap-for-v3/16/fixes thanks.

Tony
